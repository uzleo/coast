; RUN: %clang_cc1 -Os -emit-llvm -fobjc-arc -o - %s | FileCheck %s

target triple = "x86_64-apple-darwin10"

declare i8* @objc_retain(i8*)
declare void @objc_release(i8*)

; CHECK-LABEL: define void @test(
; CHECK-NOT: @objc_
; CHECK: }
define void @test(i8* %x, i1* %p) nounwind {
entry:
  br label %loop

loop:
  call i8* @objc_retain(i8* %x)
  %q = load i1, i1* %p
  br i1 %q, label %loop.more, label %exit

loop.more:
  call void @objc_release(i8* %x)
  br label %loop

exit:
  call void @objc_release(i8* %x)
  ret void
}
