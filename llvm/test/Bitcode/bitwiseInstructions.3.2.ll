; RUN: llvm-dis < %s.bc| FileCheck %s
; RUN: verify-uselistorder < %s.bc

; bitwiseOperations.3.2.ll.bc was generated by passing this file to llvm-as-3.2.
; The test checks that LLVM does not misread bitwise instructions from
; older bitcode files.

define void @shl(i8 %x1){
entry:
; CHECK: %res1 = shl i8 %x1, %x1
  %res1 = shl i8 %x1, %x1

; CHECK: %res2 = shl nuw i8 %x1, %x1
  %res2 = shl nuw i8 %x1, %x1

; CHECK: %res3 = shl nsw i8 %x1, %x1
  %res3 = shl nsw i8 %x1, %x1

; CHECK: %res4 = shl nuw nsw i8 %x1, %x1
  %res4 = shl nuw nsw i8 %x1, %x1

  ret void
}

define void @lshr(i8 %x1){
entry:
; CHECK: %res1 = lshr i8 %x1, %x1
  %res1 = lshr i8 %x1, %x1

; CHECK: %res2 = lshr exact i8 %x1, %x1
  %res2 = lshr exact i8 %x1, %x1

  ret void
}

define void @ashr(i8 %x1){
entry:
; CHECK: %res1 = ashr i8 %x1, %x1
  %res1 = ashr i8 %x1, %x1

; CHECK-NEXT: %res2 = ashr exact i8 %x1, %x1
  %res2 = ashr exact i8 %x1, %x1

  ret void
}

define void @and(i8 %x1){
entry:
; CHECK: %res1 = and i8 %x1, %x1
  %res1 = and i8 %x1, %x1

  ret void
}

define void @or(i8 %x1){
entry:
; CHECK: %res1 = or i8 %x1, %x1
  %res1 = or i8 %x1, %x1

  ret void
}

define void @xor(i8 %x1){
entry:
; CHECK: %res1 = xor i8 %x1, %x1
  %res1 = xor i8 %x1, %x1

  ret void
}
