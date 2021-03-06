; RUN: llc -march=amdgcn -verify-machineinstrs < %s | FileCheck -check-prefix=GCN -check-prefix=FUNC %s
; RUN: llc -march=amdgcn -mcpu=tonga -verify-machineinstrs < %s | FileCheck -check-prefix=GCN -check-prefix=FUNC %s
; RUN: llc -march=r600 -mcpu=redwood < %s | FileCheck -check-prefix=EG -check-prefix=FUNC %s

; FUNC-LABEL: {{^}}local_load_i16:
; GCN: ds_read_u16 v{{[0-9]+}}

; EG: LDS_USHORT_READ_RET
define void @local_load_i16(i16 addrspace(3)* %out, i16 addrspace(3)* %in) {
entry:
  %ld = load i16, i16 addrspace(3)* %in
  store i16 %ld, i16 addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_load_v2i16:
; GCN: ds_read_b32

; EG: LDS_READ_RET
define void @local_load_v2i16(<2 x i16> addrspace(3)* %out, <2 x i16> addrspace(3)* %in) {
entry:
  %ld = load <2 x i16>, <2 x i16> addrspace(3)* %in
  store <2 x i16> %ld, <2 x i16> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_load_v3i16:
; GCN: ds_read_b64
; GCN-DAG: ds_write_b32
; GCN-DAG: ds_write_b16

; EG-DAG: LDS_USHORT_READ_RET
; EG-DAG: LDS_READ_RET
define void @local_load_v3i16(<3 x i16> addrspace(3)* %out, <3 x i16> addrspace(3)* %in) {
entry:
  %ld = load <3 x i16>, <3 x i16> addrspace(3)* %in
  store <3 x i16> %ld, <3 x i16> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_load_v4i16:
; GCN: ds_read_b64

; EG: LDS_READ_RET
; EG: LDS_READ_RET
define void @local_load_v4i16(<4 x i16> addrspace(3)* %out, <4 x i16> addrspace(3)* %in) {
entry:
  %ld = load <4 x i16>, <4 x i16> addrspace(3)* %in
  store <4 x i16> %ld, <4 x i16> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_load_v8i16:
; GCN: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:1{{$}}

; EG: LDS_READ_RET
; EG: LDS_READ_RET
; EG: LDS_READ_RET
; EG: LDS_READ_RET
define void @local_load_v8i16(<8 x i16> addrspace(3)* %out, <8 x i16> addrspace(3)* %in) {
entry:
  %ld = load <8 x i16>, <8 x i16> addrspace(3)* %in
  store <8 x i16> %ld, <8 x i16> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_load_v16i16:
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:3 offset1:2{{$}}
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:1{{$}}


; EG: LDS_READ_RET
; EG: LDS_READ_RET
; EG: LDS_READ_RET
; EG: LDS_READ_RET

; EG: LDS_READ_RET
; EG: LDS_READ_RET
; EG: LDS_READ_RET
; EG: LDS_READ_RET
define void @local_load_v16i16(<16 x i16> addrspace(3)* %out, <16 x i16> addrspace(3)* %in) {
entry:
  %ld = load <16 x i16>, <16 x i16> addrspace(3)* %in
  store <16 x i16> %ld, <16 x i16> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_i16_to_i32:
; GCN: ds_read_u16
; GCN: ds_write_b32

; EG: LDS_USHORT_READ_RET
define void @local_zextload_i16_to_i32(i32 addrspace(3)* %out, i16 addrspace(3)* %in) #0 {
  %a = load i16, i16 addrspace(3)* %in
  %ext = zext i16 %a to i32
  store i32 %ext, i32 addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_i16_to_i32:
; GCN-NOT: s_wqm_b64
; GCN: s_mov_b32 m0
; GCN: ds_read_i16

; EG: LDS_USHORT_READ_RET
; EG: BFE_INT
define void @local_sextload_i16_to_i32(i32 addrspace(3)* %out, i16 addrspace(3)* %in) #0 {
  %a = load i16, i16 addrspace(3)* %in
  %ext = sext i16 %a to i32
  store i32 %ext, i32 addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v1i16_to_v1i32:
; GCN: ds_read_u16
define void @local_zextload_v1i16_to_v1i32(<1 x i32> addrspace(3)* %out, <1 x i16> addrspace(3)* %in) #0 {
  %load = load <1 x i16>, <1 x i16> addrspace(3)* %in
  %ext = zext <1 x i16> %load to <1 x i32>
  store <1 x i32> %ext, <1 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v1i16_to_v1i32:
; GCN: ds_read_i16
define void @local_sextload_v1i16_to_v1i32(<1 x i32> addrspace(3)* %out, <1 x i16> addrspace(3)* %in) #0 {
  %load = load <1 x i16>, <1 x i16> addrspace(3)* %in
  %ext = sext <1 x i16> %load to <1 x i32>
  store <1 x i32> %ext, <1 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v2i16_to_v2i32:
; GCN-NOT: s_wqm_b64
; GCN: s_mov_b32 m0
; GCN: ds_read_b32

; EG: LDS_USHORT_READ_RET
; EG: LDS_USHORT_READ_RET
define void @local_zextload_v2i16_to_v2i32(<2 x i32> addrspace(3)* %out, <2 x i16> addrspace(3)* %in) #0 {
  %load = load <2 x i16>, <2 x i16> addrspace(3)* %in
  %ext = zext <2 x i16> %load to <2 x i32>
  store <2 x i32> %ext, <2 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v2i16_to_v2i32:
; GCN-NOT: s_wqm_b64
; GCN: s_mov_b32 m0
; GCN: ds_read_b32

; EG-DAG: LDS_USHORT_READ_RET
; EG-DAG: LDS_USHORT_READ_RET
; EG-DAG: BFE_INT
; EG-DAG: BFE_INT
define void @local_sextload_v2i16_to_v2i32(<2 x i32> addrspace(3)* %out, <2 x i16> addrspace(3)* %in) #0 {
  %load = load <2 x i16>, <2 x i16> addrspace(3)* %in
  %ext = sext <2 x i16> %load to <2 x i32>
  store <2 x i32> %ext, <2 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_local_zextload_v3i16_to_v3i32:
; GCN: ds_read_b64
; GCN-DAG: ds_write_b32
; GCN-DAG: ds_write_b64
define void @local_local_zextload_v3i16_to_v3i32(<3 x i32> addrspace(3)* %out, <3 x i16> addrspace(3)* %in) {
entry:
  %ld = load <3 x i16>, <3 x i16> addrspace(3)* %in
  %ext = zext <3 x i16> %ld to <3 x i32>
  store <3 x i32> %ext, <3 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_local_sextload_v3i16_to_v3i32:
; GCN: ds_read_b64
; GCN-DAG: ds_write_b32
; GCN-DAG: ds_write_b64
define void @local_local_sextload_v3i16_to_v3i32(<3 x i32> addrspace(3)* %out, <3 x i16> addrspace(3)* %in) {
entry:
  %ld = load <3 x i16>, <3 x i16> addrspace(3)* %in
  %ext = sext <3 x i16> %ld to <3 x i32>
  store <3 x i32> %ext, <3 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_local_zextload_v4i16_to_v4i32:
; GCN-NOT: s_wqm_b64
; GCN: s_mov_b32 m0
; GCN: ds_read_b64

; EG: LDS_USHORT_READ_RET
; EG: LDS_USHORT_READ_RET
; EG: LDS_USHORT_READ_RET
; EG: LDS_USHORT_READ_RET
define void @local_local_zextload_v4i16_to_v4i32(<4 x i32> addrspace(3)* %out, <4 x i16> addrspace(3)* %in) #0 {
  %load = load <4 x i16>, <4 x i16> addrspace(3)* %in
  %ext = zext <4 x i16> %load to <4 x i32>
  store <4 x i32> %ext, <4 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v4i16_to_v4i32:
; GCN-NOT: s_wqm_b64
; GCN: s_mov_b32 m0
; GCN: ds_read_b64

; EG-DAG: LDS_USHORT_READ_RET
; EG-DAG: LDS_USHORT_READ_RET
; EG-DAG: LDS_USHORT_READ_RET
; EG-DAG: LDS_USHORT_READ_RET
; EG-DAG: BFE_INT
; EG-DAG: BFE_INT
; EG-DAG: BFE_INT
; EG-DAG: BFE_INT
define void @local_sextload_v4i16_to_v4i32(<4 x i32> addrspace(3)* %out, <4 x i16> addrspace(3)* %in) #0 {
  %load = load <4 x i16>, <4 x i16> addrspace(3)* %in
  %ext = sext <4 x i16> %load to <4 x i32>
  store <4 x i32> %ext, <4 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v8i16_to_v8i32:
; GCN: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset1:1{{$}}
define void @local_zextload_v8i16_to_v8i32(<8 x i32> addrspace(3)* %out, <8 x i16> addrspace(3)* %in) #0 {
  %load = load <8 x i16>, <8 x i16> addrspace(3)* %in
  %ext = zext <8 x i16> %load to <8 x i32>
  store <8 x i32> %ext, <8 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v8i16_to_v8i32:
; GCN: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset1:1{{$}}
define void @local_sextload_v8i16_to_v8i32(<8 x i32> addrspace(3)* %out, <8 x i16> addrspace(3)* %in) #0 {
  %load = load <8 x i16>, <8 x i16> addrspace(3)* %in
  %ext = sext <8 x i16> %load to <8 x i32>
  store <8 x i32> %ext, <8 x i32> addrspace(3)* %out
  ret void
}

; FIXME: Should have 2 ds_read_b64
; FUNC-LABEL: {{^}}local_zextload_v16i16_to_v16i32:
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:1 offset1:2{{$}}
; GCN-DAG: ds_read_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+$}}
; GCN-DAG: ds_read_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset:24

; GCN: ds_write2_b64
; GCN: ds_write2_b64
; GCN: ds_write2_b64
; GCN: ds_write2_b64
define void @local_zextload_v16i16_to_v16i32(<16 x i32> addrspace(3)* %out, <16 x i16> addrspace(3)* %in) #0 {
  %load = load <16 x i16>, <16 x i16> addrspace(3)* %in
  %ext = zext <16 x i16> %load to <16 x i32>
  store <16 x i32> %ext, <16 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v16i16_to_v16i32:
; GCN-DAG: ds_read_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+$}}
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:3 offset1:1{{$}}
; GCN-DAG: ds_read_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset:16{{$}}
define void @local_sextload_v16i16_to_v16i32(<16 x i32> addrspace(3)* %out, <16 x i16> addrspace(3)* %in) #0 {
  %load = load <16 x i16>, <16 x i16> addrspace(3)* %in
  %ext = sext <16 x i16> %load to <16 x i32>
  store <16 x i32> %ext, <16 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v32i16_to_v32i32:
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset1:1{{$}}
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:2 offset1:3
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:4 offset1:5
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:6 offset1:7
define void @local_zextload_v32i16_to_v32i32(<32 x i32> addrspace(3)* %out, <32 x i16> addrspace(3)* %in) #0 {
  %load = load <32 x i16>, <32 x i16> addrspace(3)* %in
  %ext = zext <32 x i16> %load to <32 x i32>
  store <32 x i32> %ext, <32 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v32i16_to_v32i32:
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:1 offset1:2{{$}}
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:3 offset1:4
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:5{{$}}
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:6 offset1:7
define void @local_sextload_v32i16_to_v32i32(<32 x i32> addrspace(3)* %out, <32 x i16> addrspace(3)* %in) #0 {
  %load = load <32 x i16>, <32 x i16> addrspace(3)* %in
  %ext = sext <32 x i16> %load to <32 x i32>
  store <32 x i32> %ext, <32 x i32> addrspace(3)* %out
  ret void
}

; FIXME: Missed read2
; FUNC-LABEL: {{^}}local_zextload_v64i16_to_v64i32:
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:11 offset1:15
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset1:1{{$}}
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:2 offset1:3
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:4 offset1:5
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:6 offset1:7
; GCN-DAG: ds_read_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset:64
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:9 offset1:10
; GCN-DAG: ds_read2_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset0:12 offset1:13
; GCN-DAG: ds_read_b64 v{{\[[0-9]+:[0-9]+\]}}, v{{[0-9]+}} offset:112
define void @local_zextload_v64i16_to_v64i32(<64 x i32> addrspace(3)* %out, <64 x i16> addrspace(3)* %in) #0 {
  %load = load <64 x i16>, <64 x i16> addrspace(3)* %in
  %ext = zext <64 x i16> %load to <64 x i32>
  store <64 x i32> %ext, <64 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v64i16_to_v64i32:
define void @local_sextload_v64i16_to_v64i32(<64 x i32> addrspace(3)* %out, <64 x i16> addrspace(3)* %in) #0 {
  %load = load <64 x i16>, <64 x i16> addrspace(3)* %in
  %ext = sext <64 x i16> %load to <64 x i32>
  store <64 x i32> %ext, <64 x i32> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_i16_to_i64:
; GCN-DAG: ds_read_u16 v[[LO:[0-9]+]],
; GCN-DAG: v_mov_b32_e32 v[[HI:[0-9]+]], 0{{$}}

; GCN: ds_write_b64 v{{[0-9]+}}, v{{\[}}[[LO]]:[[HI]]]
define void @local_zextload_i16_to_i64(i64 addrspace(3)* %out, i16 addrspace(3)* %in) #0 {
  %a = load i16, i16 addrspace(3)* %in
  %ext = zext i16 %a to i64
  store i64 %ext, i64 addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_i16_to_i64:
; GCN: ds_read_i16 v[[LO:[0-9]+]],
; GCN-DAG: v_ashrrev_i32_e32 v[[HI:[0-9]+]], 31, v[[LO]]

; GCN: ds_write_b64 v{{[0-9]+}}, v{{\[}}[[LO]]:[[HI]]]
define void @local_sextload_i16_to_i64(i64 addrspace(3)* %out, i16 addrspace(3)* %in) #0 {
  %a = load i16, i16 addrspace(3)* %in
  %ext = sext i16 %a to i64
  store i64 %ext, i64 addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v1i16_to_v1i64:
define void @local_zextload_v1i16_to_v1i64(<1 x i64> addrspace(3)* %out, <1 x i16> addrspace(3)* %in) #0 {
  %load = load <1 x i16>, <1 x i16> addrspace(3)* %in
  %ext = zext <1 x i16> %load to <1 x i64>
  store <1 x i64> %ext, <1 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v1i16_to_v1i64:
define void @local_sextload_v1i16_to_v1i64(<1 x i64> addrspace(3)* %out, <1 x i16> addrspace(3)* %in) #0 {
  %load = load <1 x i16>, <1 x i16> addrspace(3)* %in
  %ext = sext <1 x i16> %load to <1 x i64>
  store <1 x i64> %ext, <1 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v2i16_to_v2i64:
define void @local_zextload_v2i16_to_v2i64(<2 x i64> addrspace(3)* %out, <2 x i16> addrspace(3)* %in) #0 {
  %load = load <2 x i16>, <2 x i16> addrspace(3)* %in
  %ext = zext <2 x i16> %load to <2 x i64>
  store <2 x i64> %ext, <2 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v2i16_to_v2i64:
define void @local_sextload_v2i16_to_v2i64(<2 x i64> addrspace(3)* %out, <2 x i16> addrspace(3)* %in) #0 {
  %load = load <2 x i16>, <2 x i16> addrspace(3)* %in
  %ext = sext <2 x i16> %load to <2 x i64>
  store <2 x i64> %ext, <2 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v4i16_to_v4i64:
define void @local_zextload_v4i16_to_v4i64(<4 x i64> addrspace(3)* %out, <4 x i16> addrspace(3)* %in) #0 {
  %load = load <4 x i16>, <4 x i16> addrspace(3)* %in
  %ext = zext <4 x i16> %load to <4 x i64>
  store <4 x i64> %ext, <4 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v4i16_to_v4i64:
define void @local_sextload_v4i16_to_v4i64(<4 x i64> addrspace(3)* %out, <4 x i16> addrspace(3)* %in) #0 {
  %load = load <4 x i16>, <4 x i16> addrspace(3)* %in
  %ext = sext <4 x i16> %load to <4 x i64>
  store <4 x i64> %ext, <4 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v8i16_to_v8i64:
define void @local_zextload_v8i16_to_v8i64(<8 x i64> addrspace(3)* %out, <8 x i16> addrspace(3)* %in) #0 {
  %load = load <8 x i16>, <8 x i16> addrspace(3)* %in
  %ext = zext <8 x i16> %load to <8 x i64>
  store <8 x i64> %ext, <8 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v8i16_to_v8i64:
define void @local_sextload_v8i16_to_v8i64(<8 x i64> addrspace(3)* %out, <8 x i16> addrspace(3)* %in) #0 {
  %load = load <8 x i16>, <8 x i16> addrspace(3)* %in
  %ext = sext <8 x i16> %load to <8 x i64>
  store <8 x i64> %ext, <8 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v16i16_to_v16i64:
define void @local_zextload_v16i16_to_v16i64(<16 x i64> addrspace(3)* %out, <16 x i16> addrspace(3)* %in) #0 {
  %load = load <16 x i16>, <16 x i16> addrspace(3)* %in
  %ext = zext <16 x i16> %load to <16 x i64>
  store <16 x i64> %ext, <16 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v16i16_to_v16i64:
define void @local_sextload_v16i16_to_v16i64(<16 x i64> addrspace(3)* %out, <16 x i16> addrspace(3)* %in) #0 {
  %load = load <16 x i16>, <16 x i16> addrspace(3)* %in
  %ext = sext <16 x i16> %load to <16 x i64>
  store <16 x i64> %ext, <16 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_zextload_v32i16_to_v32i64:
define void @local_zextload_v32i16_to_v32i64(<32 x i64> addrspace(3)* %out, <32 x i16> addrspace(3)* %in) #0 {
  %load = load <32 x i16>, <32 x i16> addrspace(3)* %in
  %ext = zext <32 x i16> %load to <32 x i64>
  store <32 x i64> %ext, <32 x i64> addrspace(3)* %out
  ret void
}

; FUNC-LABEL: {{^}}local_sextload_v32i16_to_v32i64:
define void @local_sextload_v32i16_to_v32i64(<32 x i64> addrspace(3)* %out, <32 x i16> addrspace(3)* %in) #0 {
  %load = load <32 x i16>, <32 x i16> addrspace(3)* %in
  %ext = sext <32 x i16> %load to <32 x i64>
  store <32 x i64> %ext, <32 x i64> addrspace(3)* %out
  ret void
}

; ; XFUNC-LABEL: {{^}}local_zextload_v64i16_to_v64i64:
; define void @local_zextload_v64i16_to_v64i64(<64 x i64> addrspace(3)* %out, <64 x i16> addrspace(3)* %in) #0 {
;   %load = load <64 x i16>, <64 x i16> addrspace(3)* %in
;   %ext = zext <64 x i16> %load to <64 x i64>
;   store <64 x i64> %ext, <64 x i64> addrspace(3)* %out
;   ret void
; }

; ; XFUNC-LABEL: {{^}}local_sextload_v64i16_to_v64i64:
; define void @local_sextload_v64i16_to_v64i64(<64 x i64> addrspace(3)* %out, <64 x i16> addrspace(3)* %in) #0 {
;   %load = load <64 x i16>, <64 x i16> addrspace(3)* %in
;   %ext = sext <64 x i16> %load to <64 x i64>
;   store <64 x i64> %ext, <64 x i64> addrspace(3)* %out
;   ret void
; }

attributes #0 = { nounwind }
