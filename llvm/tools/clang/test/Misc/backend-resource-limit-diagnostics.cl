// REQUIRES: amdgpu-registered-target
// RUN: not %clang_cc1 -emit-codegen-only -triple=amdgcn-- %s 2>&1 | FileCheck %s

// CHECK: error: local memory limit exceeded (480000) in use_huge_lds
kernel void use_huge_lds()
{
    volatile local int huge[120000];
    huge[0] = 2;
}
