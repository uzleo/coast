// RUN: %clang -### -c -fveclib=none %s 2>&1 | FileCheck -check-prefix CHECK-NOLIB %s
// RUN: %clang -### -c -fveclib=Accelerate %s 2>&1 | FileCheck -check-prefix CHECK-ACCELERATE %s
// RUN: not %clang -c -fveclib=something %s 2>&1 | FileCheck -check-prefix CHECK-INVALID %s

// CHECK-NOLIB: "-fveclib=none"
// CHECK-ACCELERATE: "-fveclib=Accelerate"

// CHECK-INVALID: error: invalid value 'something' in '-fveclib=something'

// RUN: %clang -fveclib=Accelerate %s -target arm64-apple-ios8.0.0 -### 2>&1 | FileCheck --check-prefix=CHECK-LINK %s
// CHECK-LINK: "-framework" "Accelerate"

// RUN: %clang -fveclib=Accelerate %s -nostdlib -target arm64-apple-ios8.0.0 -### 2>&1 | FileCheck --check-prefix=CHECK-LINK-NOSTDLIB %s
// CHECK-LINK-NOSTDLIB-NOT: "-framework" "Accelerate"

// RUN: %clang -fveclib=Accelerate %s -nodefaultlibs -target arm64-apple-ios8.0.0 -### 2>&1 | FileCheck --check-prefix=CHECK-LINK-NODEFAULTLIBS %s
// CHECK-LINK-NODEFAULTLIBS-NOT: "-framework" "Accelerate"
