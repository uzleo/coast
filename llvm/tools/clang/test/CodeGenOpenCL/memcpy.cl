// RUN: %clang_cc1 %s -ffake-address-space-map -emit-llvm -o - | FileCheck %s

// CHECK-LABEL: @test
// CHECK-NOT: addrspacecast
// CHECK: call void @llvm.memcpy.p1i8.p3i8
kernel void test(global float *g, constant float *c) {
  __builtin_memcpy(g, c, 32);
}
