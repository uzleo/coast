target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.11.0"


define i32 @main() {
entry:
  call void (...) @globalfunc()
  ret i32 0
}

declare void @globalfunc(...)
