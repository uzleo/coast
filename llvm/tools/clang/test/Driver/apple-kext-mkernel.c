// RUN: %clang -target x86_64-apple-darwin10 -mkernel -### -fsyntax-only %s 2>&1 | FileCheck --check-prefix=CHECK-X86 %s
// RUN: %clang -target x86_64-apple-darwin10 -mkernel -### -fsyntax-only -fbuiltin -fno-builtin -fcommon -fno-common %s 2>&1 | FileCheck --check-prefix=CHECK-X86 %s

// CHECK-X86: "-disable-red-zone"
// CHECK-X86: "-fno-builtin"
// CHECK-X86: "-fno-rtti"
// CHECK-X86: "-fno-common"

// RUN: %clang -target x86_64-apple-darwin10 -mkernel -### -fsyntax-only -fbuiltin -fcommon %s 2>&1 | FileCheck --check-prefix=CHECK-X86-2 %s

// CHECK-X86-2: "-disable-red-zone"
// CHECK-X86-2-NOT: "-fno-builtin"
// CHECK-X86-2: "-fno-rtti"
// CHECK-X86-2-NOT: "-fno-common"

// RUN: %clang -target x86_64-apple-darwin10 -arch armv7 -mkernel -mstrict-align -### -fsyntax-only %s 2>&1 | FileCheck --check-prefix=CHECK-ARM %s
// RUN: %clang -target x86_64-apple-darwin10 -arch armv7 -mkernel -mstrict-align -### -fsyntax-only -fbuiltin -fno-builtin -fcommon -fno-common %s 2>&1 | FileCheck --check-prefix=CHECK-ARM %s

// CHECK-ARM: "-target-feature" "+long-calls"
// CHECK-ARM: "-target-feature" "+strict-align"
// CHECK-ARM-NOT: "-target-feature" "+strict-align"
// CHECK-ARM: "-fno-builtin"
// CHECK-ARM: "-fno-rtti"
// CHECK-ARM: "-fno-common"

// RUN: %clang -target x86_64-apple-darwin10 \
// RUN:   -Werror -fno-builtin -fno-exceptions -fno-common -fno-rtti \
// RUN:   -mkernel -fsyntax-only %s

// RUN: %clang -c %s -target armv7k-apple-watchos -fapple-kext -mwatchos-version-min=1.0.0 -### 2>&1 \
// RUN:   | FileCheck %s --check-prefix=CHECK-WATCH
// CHECK-WATCH-NOT: "-backend-option" "-arm-long-calls"
