; RUN: llc < %s | FileCheck %s

target triple = "powerpc64-unknown-linux-gnu"

define double @test() {
  %1 = fptrunc ppc_fp128 0xM818F2887B9295809800000000032D000 to double
  ret double %1
}

; CHECK: .quad -9111018957755033591

