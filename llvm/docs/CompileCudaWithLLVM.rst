===================================
Compiling CUDA C/C++ with LLVM
===================================

.. contents::
   :local:

Introduction
============

This document contains the user guides and the internals of compiling CUDA
C/C++ with LLVM. It is aimed at both users who want to compile CUDA with LLVM
and developers who want to improve LLVM for GPUs. This document assumes a basic
familiarity with CUDA. Information about CUDA programming can be found in the
`CUDA programming guide
<http://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html>`_.

How to Build LLVM with CUDA Support
===================================

CUDA support is still in development and works the best in the trunk version
of LLVM. Below is a quick summary of downloading and building the trunk
version. Consult the `Getting Started
<http://llvm.org/docs/GettingStarted.html>`_ page for more details on setting
up LLVM.

#. Checkout LLVM

   .. code-block:: console

     $ cd where-you-want-llvm-to-live
     $ svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm

#. Checkout Clang

   .. code-block:: console

     $ cd where-you-want-llvm-to-live
     $ cd llvm/tools
     $ svn co http://llvm.org/svn/llvm-project/cfe/trunk clang

#. Configure and build LLVM and Clang

   .. code-block:: console

     $ cd where-you-want-llvm-to-live
     $ mkdir build
     $ cd build
     $ cmake [options] ..
     $ make

How to Compile CUDA C/C++ with LLVM
===================================

We assume you have installed the CUDA driver and runtime. Consult the `NVIDIA
CUDA installation guide
<https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html>`_ if
you have not.

Suppose you want to compile and run the following CUDA program (``axpy.cu``)
which multiplies a ``float`` array by a ``float`` scalar (AXPY).

.. code-block:: c++

  #include <iostream>

  __global__ void axpy(float a, float* x, float* y) {
    y[threadIdx.x] = a * x[threadIdx.x];
  }

  int main(int argc, char* argv[]) {
    const int kDataLen = 4;

    float a = 2.0f;
    float host_x[kDataLen] = {1.0f, 2.0f, 3.0f, 4.0f};
    float host_y[kDataLen];

    // Copy input data to device.
    float* device_x;
    float* device_y;
    cudaMalloc(&device_x, kDataLen * sizeof(float));
    cudaMalloc(&device_y, kDataLen * sizeof(float));
    cudaMemcpy(device_x, host_x, kDataLen * sizeof(float),
               cudaMemcpyHostToDevice);

    // Launch the kernel.
    axpy<<<1, kDataLen>>>(a, device_x, device_y);

    // Copy output data to host.
    cudaDeviceSynchronize();
    cudaMemcpy(host_y, device_y, kDataLen * sizeof(float),
               cudaMemcpyDeviceToHost);

    // Print the results.
    for (int i = 0; i < kDataLen; ++i) {
      std::cout << "y[" << i << "] = " << host_y[i] << "\n";
    }

    cudaDeviceReset();
    return 0;
  }

The command line for compilation is similar to what you would use for C++.

.. code-block:: console

  $ clang++ axpy.cu -o axpy --cuda-gpu-arch=<GPU arch>  \
      -L<CUDA install path>/<lib64 or lib>              \
      -lcudart_static -ldl -lrt -pthread
  $ ./axpy
  y[0] = 2
  y[1] = 4
  y[2] = 6
  y[3] = 8

``<CUDA install path>`` is the root directory where you installed CUDA SDK,
typically ``/usr/local/cuda``. ``<GPU arch>`` is `the compute capability of
your GPU <https://developer.nvidia.com/cuda-gpus>`_. For example, if you want
to run your program on a GPU with compute capability of 3.5, you should specify
``--cuda-gpu-arch=sm_35``.

Detecting clang vs NVCC
=======================

Although clang's CUDA implementation is largely compatible with NVCC's, you may
still want to detect when you're compiling CUDA code specifically with clang.

This is tricky, because NVCC may invoke clang as part of its own compilation
process!  For example, NVCC uses the host compiler's preprocessor when
compiling for device code, and that host compiler may in fact be clang.

When clang is actually compiling CUDA code -- rather than being used as a
subtool of NVCC's -- it defines the ``__CUDA__`` macro.  ``__CUDA_ARCH__`` is
defined only in device mode (but will be defined if NVCC is using clang as a
preprocessor).  So you can use the following incantations to detect clang CUDA
compilation, in host and device modes:

.. code-block:: c++

  #if defined(__clang__) && defined(__CUDA__) && !defined(__CUDA_ARCH__)
    // clang compiling CUDA code, host mode.
  #endif

  #if defined(__clang__) && defined(__CUDA__) && defined(__CUDA_ARCH__)
    // clang compiling CUDA code, device mode.
  #endif

Both clang and nvcc define ``__CUDACC__`` during CUDA compilation.  You can
detect NVCC specifically by looking for ``__NVCC__``.

Flags that control numerical code
=================================

If you're using GPUs, you probably care about making numerical code run fast.
GPU hardware allows for more control over numerical operations than most CPUs,
but this results in more compiler options for you to juggle.

Flags you may wish to tweak include:

* ``-ffp-contract={on,off,fast}`` (defaults to ``fast`` on host and device when
  compiling CUDA) Controls whether the compiler emits fused multiply-add
  operations.

  * ``off``: never emit fma operations, and prevent ptxas from fusing multiply
    and add instructions.
  * ``on``: fuse multiplies and adds within a single statement, but never
    across statements (C11 semantics).  Prevent ptxas from fusing other
    multiplies and adds.
  * ``fast``: fuse multiplies and adds wherever profitable, even across
    statements.  Doesn't prevent ptxas from fusing additional multiplies and
    adds.

  Fused multiply-add instructions can be much faster than the unfused
  equivalents, but because the intermediate result in an fma is not rounded,
  this flag can affect numerical code.

* ``-fcuda-flush-denormals-to-zero`` (default: off) When this is enabled,
  floating point operations may flush `denormal
  <https://en.wikipedia.org/wiki/Denormal_number>`_ inputs and/or outputs to 0.
  Operations on denormal numbers are often much slower than the same operations
  on normal numbers.

* ``-fcuda-approx-transcendentals`` (default: off) When this is enabled, the
  compiler may emit calls to faster, approximate versions of transcendental
  functions, instead of using the slower, fully IEEE-compliant versions.  For
  example, this flag allows clang to emit the ptx ``sin.approx.f32``
  instruction.

  This is implied by ``-ffast-math``.

Optimizations
=============

CPU and GPU have different design philosophies and architectures. For example, a
typical CPU has branch prediction, out-of-order execution, and is superscalar,
whereas a typical GPU has none of these. Due to such differences, an
optimization pipeline well-tuned for CPUs may be not suitable for GPUs.

LLVM performs several general and CUDA-specific optimizations for GPUs. The
list below shows some of the more important optimizations for GPUs. Most of
them have been upstreamed to ``lib/Transforms/Scalar`` and
``lib/Target/NVPTX``. A few of them have not been upstreamed due to lack of a
customizable target-independent optimization pipeline.

* **Straight-line scalar optimizations**. These optimizations reduce redundancy
  in straight-line code. Details can be found in the `design document for
  straight-line scalar optimizations <https://goo.gl/4Rb9As>`_.

* **Inferring memory spaces**. `This optimization
  <https://github.com/llvm-mirror/llvm/blob/master/lib/Target/NVPTX/NVPTXInferAddressSpaces.cpp>`_
  infers the memory space of an address so that the backend can emit faster
  special loads and stores from it.

* **Aggressive loop unrooling and function inlining**. Loop unrolling and
  function inlining need to be more aggressive for GPUs than for CPUs because
  control flow transfer in GPU is more expensive. They also promote other
  optimizations such as constant propagation and SROA which sometimes speed up
  code by over 10x. An empirical inline threshold for GPUs is 1100. This
  configuration has yet to be upstreamed with a target-specific optimization
  pipeline. LLVM also provides `loop unrolling pragmas
  <http://clang.llvm.org/docs/AttributeReference.html#pragma-unroll-pragma-nounroll>`_
  and ``__attribute__((always_inline))`` for programmers to force unrolling and
  inling.

* **Aggressive speculative execution**. `This transformation
  <http://llvm.org/docs/doxygen/html/SpeculativeExecution_8cpp_source.html>`_ is
  mainly for promoting straight-line scalar optimizations which are most
  effective on code along dominator paths.

* **Memory-space alias analysis**. `This alias analysis
  <http://reviews.llvm.org/D12414>`_ infers that two pointers in different
  special memory spaces do not alias. It has yet to be integrated to the new
  alias analysis infrastructure; the new infrastructure does not run
  target-specific alias analysis.

* **Bypassing 64-bit divides**. `An existing optimization
  <http://llvm.org/docs/doxygen/html/BypassSlowDivision_8cpp_source.html>`_
  enabled in the NVPTX backend. 64-bit integer divides are much slower than
  32-bit ones on NVIDIA GPUs due to lack of a divide unit. Many of the 64-bit
  divides in our benchmarks have a divisor and dividend which fit in 32-bits at
  runtime. This optimization provides a fast path for this common case.

Publication
===========

| `gpucc: An Open-Source GPGPU Compiler <http://dl.acm.org/citation.cfm?id=2854041>`_
| Jingyue Wu, Artem Belevich, Eli Bendersky, Mark Heffernan, Chris Leary, Jacques Pienaar, Bjarke Roune, Rob Springer, Xuetian Weng, Robert Hundt
| *Proceedings of the 2016 International Symposium on Code Generation and Optimization (CGO 2016)*
| `Slides for the CGO talk <http://wujingyue.com/docs/gpucc-talk.pdf>`_

Tutorial
========

`CGO 2016 gpucc tutorial <http://wujingyue.com/docs/gpucc-tutorial.pdf>`_

Obtaining Help
==============

To obtain help on LLVM in general and its CUDA support, see `the LLVM
community <http://llvm.org/docs/#mailing-lists>`_.
