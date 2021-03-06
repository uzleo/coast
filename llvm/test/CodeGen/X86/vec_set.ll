; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-unknown -mattr=+sse2,-sse4.1 | FileCheck %s

define void @test(<8 x i16>* %b, i16 %a0, i16 %a1, i16 %a2, i16 %a3, i16 %a4, i16 %a5, i16 %a6, i16 %a7) nounwind {
; CHECK-LABEL: test:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; CHECK-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    movd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; CHECK-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; CHECK-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    movd {{.*#+}} xmm3 = mem[0],zero,zero,zero
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1],xmm3[2],xmm0[2],xmm3[3],xmm0[3]
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
; CHECK-NEXT:    movdqa %xmm3, (%eax)
; CHECK-NEXT:    retl
  %tmp = insertelement <8 x i16> zeroinitializer, i16 %a0, i32 0
  %tmp2 = insertelement <8 x i16> %tmp, i16 %a1, i32 1
  %tmp4 = insertelement <8 x i16> %tmp2, i16 %a2, i32 2
  %tmp6 = insertelement <8 x i16> %tmp4, i16 %a3, i32 3
  %tmp8 = insertelement <8 x i16> %tmp6, i16 %a4, i32 4
  %tmp10 = insertelement <8 x i16> %tmp8, i16 %a5, i32 5
  %tmp12 = insertelement <8 x i16> %tmp10, i16 %a6, i32 6
  %tmp14 = insertelement <8 x i16> %tmp12, i16 %a7, i32 7
  store <8 x i16> %tmp14, <8 x i16>* %b
  ret void
}

