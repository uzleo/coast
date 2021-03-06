; RUN: llc -mtriple=arm-eabi -mattr=+vfp2 %s -o - \
; RUN:  | FileCheck %s -check-prefix=VFP2

; RUN: llc -mtriple=arm-eabi -mattr=+neon %s -o - \
; RUN:  | FileCheck %s -check-prefix=NEON

; RUN: llc -mtriple=arm-eabi -mcpu=cortex-a8 %s -o - \
; RUN:  | FileCheck %s -check-prefix=A8

; RUN: llc -mtriple=arm-eabi -mcpu=cortex-a8 -regalloc=basic %s -o - \
; RUN:  | FileCheck %s -check-prefix=A8

; RUN: llc -mtriple=arm-eabi -mcpu=cortex-a8 --enable-unsafe-fp-math %s -o - \
; RUN:  | FileCheck %s -check-prefix=A8U

; RUN: llc -mtriple=arm-darwin -mcpu=cortex-a8 %s -o - \
; RUN:  | FileCheck %s -check-prefix=A8U

define float @t1(float %acc, float %a, float %b) nounwind {
entry:
; VFP2-LABEL: t1:
; VFP2: vnmla.f32

; NEON-LABEL: t1:
; NEON: vnmla.f32

; A8U-LABEL: t1:
; A8U: vnmul.f32 s{{[0-9]}}, s{{[0-9]}}, s{{[0-9]}}
; A8U: vsub.f32 d{{[0-9]}}, d{{[0-9]}}, d{{[0-9]}}

; A8-LABEL: t1:
; A8: vnmul.f32 s{{[0-9]}}, s{{[0-9]}}, s{{[0-9]}}
; A8: vsub.f32 s{{[0-9]}}, s{{[0-9]}}, s{{[0-9]}}
	%0 = fmul float %a, %b
	%1 = fsub float -0.0, %0
        %2 = fsub float %1, %acc
	ret float %2
}

define float @t2(float %acc, float %a, float %b) nounwind {
entry:
; VFP2-LABEL: t2:
; VFP2: vnmla.f32

; NEON-LABEL: t2:
; NEON: vnmla.f32

; A8U-LABEL: t2:
; A8U: vnmul.f32 s{{[01234]}}, s{{[01234]}}, s{{[01234]}}
; A8U: vsub.f32 d{{[0-9]}}, d{{[0-9]}}, d{{[0-9]}}

; A8-LABEL: t2:
; A8: vnmul.f32 s{{[01234]}}, s{{[01234]}}, s{{[01234]}}
; A8: vsub.f32 s{{[0-9]}}, s{{[0-9]}}, s{{[0-9]}}
	%0 = fmul float %a, %b
	%1 = fmul float -1.0, %0
        %2 = fsub float %1, %acc
	ret float %2
}

define double @t3(double %acc, double %a, double %b) nounwind {
entry:
; VFP2-LABEL: t3:
; VFP2: vnmla.f64

; NEON-LABEL: t3:
; NEON: vnmla.f64

; A8U-LABEL: t3:
; A8U: vnmul.f64 d
; A8U: vsub.f64 d

; A8-LABEL: t3:
; A8: vnmul.f64 d
; A8: vsub.f64 d
	%0 = fmul double %a, %b
	%1 = fsub double -0.0, %0
        %2 = fsub double %1, %acc
	ret double %2
}

define double @t4(double %acc, double %a, double %b) nounwind {
entry:
; VFP2-LABEL: t4:
; VFP2: vnmla.f64

; NEON-LABEL: t4:
; NEON: vnmla.f64

; A8U-LABEL: t4:
; A8U: vnmul.f64 d
; A8U: vsub.f64 d

; A8-LABEL: t4:
; A8: vnmul.f64 d
; A8: vsub.f64 d
	%0 = fmul double %a, %b
	%1 = fmul double -1.0, %0
        %2 = fsub double %1, %acc
	ret double %2
}
