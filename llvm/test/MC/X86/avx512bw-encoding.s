// RUN: llvm-mc -triple x86_64-unknown-unknown -mcpu=skx  --show-encoding %s | FileCheck %s

// CHECK: vpblendmb %zmm25, %zmm18, %zmm17
// CHECK:  encoding: [0x62,0x82,0x6d,0x40,0x66,0xc9]
          vpblendmb %zmm25, %zmm18, %zmm17

// CHECK: vpblendmb %zmm25, %zmm18, %zmm17 {%k5}
// CHECK:  encoding: [0x62,0x82,0x6d,0x45,0x66,0xc9]
          vpblendmb %zmm25, %zmm18, %zmm17 {%k5}

// CHECK: vpblendmb %zmm25, %zmm18, %zmm17 {%k5} {z}
// CHECK:  encoding: [0x62,0x82,0x6d,0xc5,0x66,0xc9]
          vpblendmb %zmm25, %zmm18, %zmm17 {%k5} {z}

// CHECK: vpblendmb (%rcx), %zmm18, %zmm17
// CHECK:  encoding: [0x62,0xe2,0x6d,0x40,0x66,0x09]
          vpblendmb (%rcx), %zmm18, %zmm17

// CHECK: vpblendmb 291(%rax,%r14,8), %zmm18, %zmm17
// CHECK:  encoding: [0x62,0xa2,0x6d,0x40,0x66,0x8c,0xf0,0x23,0x01,0x00,0x00]
          vpblendmb 291(%rax,%r14,8), %zmm18, %zmm17

// CHECK: vpblendmb 8128(%rdx), %zmm18, %zmm17
// CHECK:  encoding: [0x62,0xe2,0x6d,0x40,0x66,0x4a,0x7f]
          vpblendmb 8128(%rdx), %zmm18, %zmm17

// CHECK: vpblendmb 8192(%rdx), %zmm18, %zmm17
// CHECK:  encoding: [0x62,0xe2,0x6d,0x40,0x66,0x8a,0x00,0x20,0x00,0x00]
          vpblendmb 8192(%rdx), %zmm18, %zmm17

// CHECK: vpblendmb -8192(%rdx), %zmm18, %zmm17
// CHECK:  encoding: [0x62,0xe2,0x6d,0x40,0x66,0x4a,0x80]
          vpblendmb -8192(%rdx), %zmm18, %zmm17

// CHECK: vpblendmb -8256(%rdx), %zmm18, %zmm17
// CHECK:  encoding: [0x62,0xe2,0x6d,0x40,0x66,0x8a,0xc0,0xdf,0xff,0xff]
          vpblendmb -8256(%rdx), %zmm18, %zmm17

// CHECK: vpblendmw %zmm17, %zmm20, %zmm26
// CHECK:  encoding: [0x62,0x22,0xdd,0x40,0x66,0xd1]
          vpblendmw %zmm17, %zmm20, %zmm26

// CHECK: vpblendmw %zmm17, %zmm20, %zmm26 {%k7}
// CHECK:  encoding: [0x62,0x22,0xdd,0x47,0x66,0xd1]
          vpblendmw %zmm17, %zmm20, %zmm26 {%k7}

// CHECK: vpblendmw %zmm17, %zmm20, %zmm26 {%k7} {z}
// CHECK:  encoding: [0x62,0x22,0xdd,0xc7,0x66,0xd1]
          vpblendmw %zmm17, %zmm20, %zmm26 {%k7} {z}

// CHECK: vpblendmw (%rcx), %zmm20, %zmm26
// CHECK:  encoding: [0x62,0x62,0xdd,0x40,0x66,0x11]
          vpblendmw (%rcx), %zmm20, %zmm26

// CHECK: vpblendmw 291(%rax,%r14,8), %zmm20, %zmm26
// CHECK:  encoding: [0x62,0x22,0xdd,0x40,0x66,0x94,0xf0,0x23,0x01,0x00,0x00]
          vpblendmw 291(%rax,%r14,8), %zmm20, %zmm26

// CHECK: vpblendmw 8128(%rdx), %zmm20, %zmm26
// CHECK:  encoding: [0x62,0x62,0xdd,0x40,0x66,0x52,0x7f]
          vpblendmw 8128(%rdx), %zmm20, %zmm26

// CHECK: vpblendmw 8192(%rdx), %zmm20, %zmm26
// CHECK:  encoding: [0x62,0x62,0xdd,0x40,0x66,0x92,0x00,0x20,0x00,0x00]
          vpblendmw 8192(%rdx), %zmm20, %zmm26

// CHECK: vpblendmw -8192(%rdx), %zmm20, %zmm26
// CHECK:  encoding: [0x62,0x62,0xdd,0x40,0x66,0x52,0x80]
          vpblendmw -8192(%rdx), %zmm20, %zmm26

// CHECK: vpblendmw -8256(%rdx), %zmm20, %zmm26
// CHECK:  encoding: [0x62,0x62,0xdd,0x40,0x66,0x92,0xc0,0xdf,0xff,0xff]
          vpblendmw -8256(%rdx), %zmm20, %zmm26

// CHECK: vptestmb %zmm19, %zmm17, %k5
// CHECK:  encoding: [0x62,0xb2,0x75,0x40,0x26,0xeb]
          vptestmb %zmm19, %zmm17, %k5

// CHECK: vptestmb %zmm19, %zmm17, %k5 {%k3}
// CHECK:  encoding: [0x62,0xb2,0x75,0x43,0x26,0xeb]
          vptestmb %zmm19, %zmm17, %k5 {%k3}

// CHECK: vptestmb (%rcx), %zmm17, %k5
// CHECK:  encoding: [0x62,0xf2,0x75,0x40,0x26,0x29]
          vptestmb (%rcx), %zmm17, %k5

// CHECK: vptestmb 291(%rax,%r14,8), %zmm17, %k5
// CHECK:  encoding: [0x62,0xb2,0x75,0x40,0x26,0xac,0xf0,0x23,0x01,0x00,0x00]
          vptestmb 291(%rax,%r14,8), %zmm17, %k5

// CHECK: vptestmb 8128(%rdx), %zmm17, %k5
// CHECK:  encoding: [0x62,0xf2,0x75,0x40,0x26,0x6a,0x7f]
          vptestmb 8128(%rdx), %zmm17, %k5

// CHECK: vptestmb 8192(%rdx), %zmm17, %k5
// CHECK:  encoding: [0x62,0xf2,0x75,0x40,0x26,0xaa,0x00,0x20,0x00,0x00]
          vptestmb 8192(%rdx), %zmm17, %k5

// CHECK: vptestmb -8192(%rdx), %zmm17, %k5
// CHECK:  encoding: [0x62,0xf2,0x75,0x40,0x26,0x6a,0x80]
          vptestmb -8192(%rdx), %zmm17, %k5

// CHECK: vptestmb -8256(%rdx), %zmm17, %k5
// CHECK:  encoding: [0x62,0xf2,0x75,0x40,0x26,0xaa,0xc0,0xdf,0xff,0xff]
          vptestmb -8256(%rdx), %zmm17, %k5

// CHECK: vptestmw %zmm19, %zmm29, %k4
// CHECK:  encoding: [0x62,0xb2,0x95,0x40,0x26,0xe3]
          vptestmw %zmm19, %zmm29, %k4

// CHECK: vptestmw %zmm19, %zmm29, %k4 {%k2}
// CHECK:  encoding: [0x62,0xb2,0x95,0x42,0x26,0xe3]
          vptestmw %zmm19, %zmm29, %k4 {%k2}

// CHECK: vptestmw (%rcx), %zmm29, %k4
// CHECK:  encoding: [0x62,0xf2,0x95,0x40,0x26,0x21]
          vptestmw (%rcx), %zmm29, %k4

// CHECK: vptestmw 291(%rax,%r14,8), %zmm29, %k4
// CHECK:  encoding: [0x62,0xb2,0x95,0x40,0x26,0xa4,0xf0,0x23,0x01,0x00,0x00]
          vptestmw 291(%rax,%r14,8), %zmm29, %k4

// CHECK: vptestmw 8128(%rdx), %zmm29, %k4
// CHECK:  encoding: [0x62,0xf2,0x95,0x40,0x26,0x62,0x7f]
          vptestmw 8128(%rdx), %zmm29, %k4

// CHECK: vptestmw 8192(%rdx), %zmm29, %k4
// CHECK:  encoding: [0x62,0xf2,0x95,0x40,0x26,0xa2,0x00,0x20,0x00,0x00]
          vptestmw 8192(%rdx), %zmm29, %k4

// CHECK: vptestmw -8192(%rdx), %zmm29, %k4
// CHECK:  encoding: [0x62,0xf2,0x95,0x40,0x26,0x62,0x80]
          vptestmw -8192(%rdx), %zmm29, %k4

// CHECK: vptestmw -8256(%rdx), %zmm29, %k4
// CHECK:  encoding: [0x62,0xf2,0x95,0x40,0x26,0xa2,0xc0,0xdf,0xff,0xff]
          vptestmw -8256(%rdx), %zmm29, %k4

// CHECK: vptestnmb %zmm23, %zmm24, %k2
// CHECK:  encoding: [0x62,0xb2,0x3e,0x40,0x26,0xd7]
          vptestnmb %zmm23, %zmm24, %k2

// CHECK: vptestnmb %zmm23, %zmm24, %k2 {%k7}
// CHECK:  encoding: [0x62,0xb2,0x3e,0x47,0x26,0xd7]
          vptestnmb %zmm23, %zmm24, %k2 {%k7}

// CHECK: vptestnmb (%rcx), %zmm24, %k2
// CHECK:  encoding: [0x62,0xf2,0x3e,0x40,0x26,0x11]
          vptestnmb (%rcx), %zmm24, %k2

// CHECK: vptestnmb 291(%rax,%r14,8), %zmm24, %k2
// CHECK:  encoding: [0x62,0xb2,0x3e,0x40,0x26,0x94,0xf0,0x23,0x01,0x00,0x00]
          vptestnmb 291(%rax,%r14,8), %zmm24, %k2

// CHECK: vptestnmb 8128(%rdx), %zmm24, %k2
// CHECK:  encoding: [0x62,0xf2,0x3e,0x40,0x26,0x52,0x7f]
          vptestnmb 8128(%rdx), %zmm24, %k2

// CHECK: vptestnmb 8192(%rdx), %zmm24, %k2
// CHECK:  encoding: [0x62,0xf2,0x3e,0x40,0x26,0x92,0x00,0x20,0x00,0x00]
          vptestnmb 8192(%rdx), %zmm24, %k2

// CHECK: vptestnmb -8192(%rdx), %zmm24, %k2
// CHECK:  encoding: [0x62,0xf2,0x3e,0x40,0x26,0x52,0x80]
          vptestnmb -8192(%rdx), %zmm24, %k2

// CHECK: vptestnmb -8256(%rdx), %zmm24, %k2
// CHECK:  encoding: [0x62,0xf2,0x3e,0x40,0x26,0x92,0xc0,0xdf,0xff,0xff]
          vptestnmb -8256(%rdx), %zmm24, %k2

// CHECK: vptestnmw %zmm27, %zmm18, %k4
// CHECK:  encoding: [0x62,0x92,0xee,0x40,0x26,0xe3]
          vptestnmw %zmm27, %zmm18, %k4

// CHECK: vptestnmw %zmm27, %zmm18, %k4 {%k5}
// CHECK:  encoding: [0x62,0x92,0xee,0x45,0x26,0xe3]
          vptestnmw %zmm27, %zmm18, %k4 {%k5}

// CHECK: vptestnmw (%rcx), %zmm18, %k4
// CHECK:  encoding: [0x62,0xf2,0xee,0x40,0x26,0x21]
          vptestnmw (%rcx), %zmm18, %k4

// CHECK: vptestnmw 291(%rax,%r14,8), %zmm18, %k4
// CHECK:  encoding: [0x62,0xb2,0xee,0x40,0x26,0xa4,0xf0,0x23,0x01,0x00,0x00]
          vptestnmw 291(%rax,%r14,8), %zmm18, %k4

// CHECK: vptestnmw 8128(%rdx), %zmm18, %k4
// CHECK:  encoding: [0x62,0xf2,0xee,0x40,0x26,0x62,0x7f]
          vptestnmw 8128(%rdx), %zmm18, %k4

// CHECK: vptestnmw 8192(%rdx), %zmm18, %k4
// CHECK:  encoding: [0x62,0xf2,0xee,0x40,0x26,0xa2,0x00,0x20,0x00,0x00]
          vptestnmw 8192(%rdx), %zmm18, %k4

// CHECK: vptestnmw -8192(%rdx), %zmm18, %k4
// CHECK:  encoding: [0x62,0xf2,0xee,0x40,0x26,0x62,0x80]
          vptestnmw -8192(%rdx), %zmm18, %k4

// CHECK: vptestnmw -8256(%rdx), %zmm18, %k4
// CHECK:  encoding: [0x62,0xf2,0xee,0x40,0x26,0xa2,0xc0,0xdf,0xff,0xff]
          vptestnmw -8256(%rdx), %zmm18, %k4

// CHECK: vptestnmb %zmm19, %zmm27, %k3
// CHECK:  encoding: [0x62,0xb2,0x26,0x40,0x26,0xdb]
          vptestnmb %zmm19, %zmm27, %k3

// CHECK: vptestnmb %zmm19, %zmm27, %k3 {%k2}
// CHECK:  encoding: [0x62,0xb2,0x26,0x42,0x26,0xdb]
          vptestnmb %zmm19, %zmm27, %k3 {%k2}

// CHECK: vptestnmb (%rcx), %zmm27, %k3
// CHECK:  encoding: [0x62,0xf2,0x26,0x40,0x26,0x19]
          vptestnmb (%rcx), %zmm27, %k3

// CHECK: vptestnmb 4660(%rax,%r14,8), %zmm27, %k3
// CHECK:  encoding: [0x62,0xb2,0x26,0x40,0x26,0x9c,0xf0,0x34,0x12,0x00,0x00]
          vptestnmb 4660(%rax,%r14,8), %zmm27, %k3

// CHECK: vptestnmb 8128(%rdx), %zmm27, %k3
// CHECK:  encoding: [0x62,0xf2,0x26,0x40,0x26,0x5a,0x7f]
          vptestnmb 8128(%rdx), %zmm27, %k3

// CHECK: vptestnmb 8192(%rdx), %zmm27, %k3
// CHECK:  encoding: [0x62,0xf2,0x26,0x40,0x26,0x9a,0x00,0x20,0x00,0x00]
          vptestnmb 8192(%rdx), %zmm27, %k3

// CHECK: vptestnmb -8192(%rdx), %zmm27, %k3
// CHECK:  encoding: [0x62,0xf2,0x26,0x40,0x26,0x5a,0x80]
          vptestnmb -8192(%rdx), %zmm27, %k3

// CHECK: vptestnmb -8256(%rdx), %zmm27, %k3
// CHECK:  encoding: [0x62,0xf2,0x26,0x40,0x26,0x9a,0xc0,0xdf,0xff,0xff]
          vptestnmb -8256(%rdx), %zmm27, %k3

// CHECK: vptestnmw %zmm21, %zmm17, %k2
// CHECK:  encoding: [0x62,0xb2,0xf6,0x40,0x26,0xd5]
          vptestnmw %zmm21, %zmm17, %k2

// CHECK: vptestnmw %zmm21, %zmm17, %k2 {%k4}
// CHECK:  encoding: [0x62,0xb2,0xf6,0x44,0x26,0xd5]
          vptestnmw %zmm21, %zmm17, %k2 {%k4}

// CHECK: vptestnmw (%rcx), %zmm17, %k2
// CHECK:  encoding: [0x62,0xf2,0xf6,0x40,0x26,0x11]
          vptestnmw (%rcx), %zmm17, %k2

// CHECK: vptestnmw 4660(%rax,%r14,8), %zmm17, %k2
// CHECK:  encoding: [0x62,0xb2,0xf6,0x40,0x26,0x94,0xf0,0x34,0x12,0x00,0x00]
          vptestnmw 4660(%rax,%r14,8), %zmm17, %k2

// CHECK: vptestnmw 8128(%rdx), %zmm17, %k2
// CHECK:  encoding: [0x62,0xf2,0xf6,0x40,0x26,0x52,0x7f]
          vptestnmw 8128(%rdx), %zmm17, %k2

// CHECK: vptestnmw 8192(%rdx), %zmm17, %k2
// CHECK:  encoding: [0x62,0xf2,0xf6,0x40,0x26,0x92,0x00,0x20,0x00,0x00]
          vptestnmw 8192(%rdx), %zmm17, %k2

// CHECK: vptestnmw -8192(%rdx), %zmm17, %k2
// CHECK:  encoding: [0x62,0xf2,0xf6,0x40,0x26,0x52,0x80]
          vptestnmw -8192(%rdx), %zmm17, %k2

// CHECK: vptestnmw -8256(%rdx), %zmm17, %k2
// CHECK:  encoding: [0x62,0xf2,0xf6,0x40,0x26,0x92,0xc0,0xdf,0xff,0xff]
          vptestnmw -8256(%rdx), %zmm17, %k2

// CHECK: vpmovb2m %zmm28, %k5
// CHECK:  encoding: [0x62,0x92,0x7e,0x48,0x29,0xec]
          vpmovb2m %zmm28, %k5

// CHECK: vpmovw2m %zmm30, %k3
// CHECK:  encoding: [0x62,0x92,0xfe,0x48,0x29,0xde]
          vpmovw2m %zmm30, %k3

// CHECK: vpmovm2b %k3, %zmm18
// CHECK:  encoding: [0x62,0xe2,0x7e,0x48,0x28,0xd3]
          vpmovm2b %k3, %zmm18

// CHECK: vpmovm2w %k5, %zmm24
// CHECK:  encoding: [0x62,0x62,0xfe,0x48,0x28,0xc5]
          vpmovm2w %k5, %zmm24

