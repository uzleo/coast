; RUN: opt -cost-model -analyze -mtriple=amdgcn-unknown-amdhsa -mattr=+half-rate-64-ops < %s | FileCheck -check-prefix=FASTF64 -check-prefix=ALL %s
; RUN: opt -cost-model -analyze -mtriple=amdgcn-unknown-amdhsa -mattr=-half-rate-64-ops < %s | FileCheck -check-prefix=SLOWF64 -check-prefix=ALL %s

; ALL: 'fadd_f32'
; ALL: estimated cost of 1 for {{.*}} fadd float
define void @fadd_f32(float addrspace(1)* %out, float addrspace(1)* %vaddr, float %b) #0 {
  %vec = load float, float addrspace(1)* %vaddr
  %add = fadd float %vec, %b
  store float %add, float addrspace(1)* %out
  ret void
}

; ALL: 'fadd_v2f32'
; ALL: estimated cost of 2 for {{.*}} fadd <2 x float>
define void @fadd_v2f32(<2 x float> addrspace(1)* %out, <2 x float> addrspace(1)* %vaddr, <2 x float> %b) #0 {
  %vec = load <2 x float>, <2 x float> addrspace(1)* %vaddr
  %add = fadd <2 x float> %vec, %b
  store <2 x float> %add, <2 x float> addrspace(1)* %out
  ret void
}

; ALL: 'fadd_v3f32'
; ALL: estimated cost of 3 for {{.*}} fadd <3 x float>
define void @fadd_v3f32(<3 x float> addrspace(1)* %out, <3 x float> addrspace(1)* %vaddr, <3 x float> %b) #0 {
  %vec = load <3 x float>, <3 x float> addrspace(1)* %vaddr
  %add = fadd <3 x float> %vec, %b
  store <3 x float> %add, <3 x float> addrspace(1)* %out
  ret void
}

; ALL: 'fadd_f64'
; FASTF64: estimated cost of 2 for {{.*}} fadd double
; SLOWF64: estimated cost of 3 for {{.*}} fadd double
define void @fadd_f64(double addrspace(1)* %out, double addrspace(1)* %vaddr, double %b) #0 {
  %vec = load double, double addrspace(1)* %vaddr
  %add = fadd double %vec, %b
  store double %add, double addrspace(1)* %out
  ret void
}

; ALL: 'fadd_v2f64'
; FASTF64: estimated cost of 4 for {{.*}} fadd <2 x double>
; SLOWF64: estimated cost of 6 for {{.*}} fadd <2 x double>
define void @fadd_v2f64(<2 x double> addrspace(1)* %out, <2 x double> addrspace(1)* %vaddr, <2 x double> %b) #0 {
  %vec = load <2 x double>, <2 x double> addrspace(1)* %vaddr
  %add = fadd <2 x double> %vec, %b
  store <2 x double> %add, <2 x double> addrspace(1)* %out
  ret void
}

; ALL: 'fadd_v3f64'
; FASTF64: estimated cost of 6 for {{.*}} fadd <3 x double>
; SLOWF64: estimated cost of 9 for {{.*}} fadd <3 x double>
define void @fadd_v3f64(<3 x double> addrspace(1)* %out, <3 x double> addrspace(1)* %vaddr, <3 x double> %b) #0 {
  %vec = load <3 x double>, <3 x double> addrspace(1)* %vaddr
  %add = fadd <3 x double> %vec, %b
  store <3 x double> %add, <3 x double> addrspace(1)* %out
  ret void
}

; ALL 'fadd_f16'
; ALL estimated cost of 1 for {{.*}} fadd half
define void @fadd_f16(half addrspace(1)* %out, half addrspace(1)* %vaddr, half %b) #0 {
  %vec = load half, half addrspace(1)* %vaddr
  %add = fadd half %vec, %b
  store half %add, half addrspace(1)* %out
  ret void
}

; ALL 'fadd_v2f16'
; ALL estimated cost of 2 for {{.*}} fadd <2 x half>
define void @fadd_v2f16(<2 x half> addrspace(1)* %out, <2 x half> addrspace(1)* %vaddr, <2 x half> %b) #0 {
  %vec = load <2 x half>, <2 x half> addrspace(1)* %vaddr
  %add = fadd <2 x half> %vec, %b
  store <2 x half> %add, <2 x half> addrspace(1)* %out
  ret void
}

; ALL 'fadd_v4f16'
; ALL estimated cost of 4 for {{.*}} fadd <4 x half>
define void @fadd_v4f16(<4 x half> addrspace(1)* %out, <4 x half> addrspace(1)* %vaddr, <4 x half> %b) #0 {
  %vec = load <4 x half>, <4 x half> addrspace(1)* %vaddr
  %add = fadd <4 x half> %vec, %b
  store <4 x half> %add, <4 x half> addrspace(1)* %out
  ret void
}

attributes #0 = { nounwind }
