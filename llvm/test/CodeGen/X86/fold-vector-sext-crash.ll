; RUN: llc < %s -mcpu=core-avx-i -mtriple=i386-unknown-linux-gnu -mattr=+avx,+popcnt,+cmov

; Make sure that we don't introduce illegal build_vector dag nodes
; when trying to fold a sign_extend of a constant build_vector.
; After r200234 the test case below was crashing the compiler with an assertion failure
; due to an illegal build_vector of type MVT::v4i64.

define <4 x i64> @foo(<4 x i64> %A) {
  %1 = select <4 x i1> <i1 true, i1 true, i1 false, i1 false>, <4 x i64> %A, <4 x i64><i64 undef, i64 undef, i64 0, i64 0>
  ret <4 x i64> %1
}

