// RUN: %clang_cc1 -analyze -analyzer-checker=core,unix -verify %s
// expected-no-diagnostics

// Testing core functionality of the SValBuilder.

int SValBuilderLogicNoCrash(int *x) {
  return 3 - (int)(x +3);
}

// http://llvm.org/bugs/show_bug.cgi?id=15863
// Don't crash when mixing 'bool' and 'int' in implicit comparisons to 0.
void pr15863() {
  extern int getBool();
  _Bool a = getBool();
  (void)!a; // no-warning
}
