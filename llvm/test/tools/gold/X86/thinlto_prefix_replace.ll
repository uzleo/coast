; Check that changing the output path via thinlto-prefix-replace works
; RUN: mkdir -p %T/oldpath
; RUN: opt -module-summary %s -o %T/oldpath/thinlto_prefix_replace.o
; Ensure that there is no existing file at the new path, so we properly
; test the creation of the new file there.
; RUN: rm -f %T/newpath/thinlto_prefix_replace.o.thinlto.bc
; RUN: %gold -plugin %llvmshlibdir/LLVMgold.so \
; RUN:    --plugin-opt=thinlto \
; RUN:    --plugin-opt=thinlto-index-only \
; RUN:    --plugin-opt=thinlto-prefix-replace="%T/oldpath/;%T/newpath/" \
; RUN:    -shared %T/oldpath/thinlto_prefix_replace.o -o %T/thinlto_prefix_replace
; RUN: ls %T/newpath/thinlto_prefix_replace.o.thinlto.bc

define void @f() {
entry:
  ret void
}
