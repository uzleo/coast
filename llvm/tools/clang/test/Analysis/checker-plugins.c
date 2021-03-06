// RUN: %clang_cc1 -load %llvmshlibdir/SampleAnalyzerPlugin%pluginext -analyze -analyzer-checker='example.MainCallChecker' -verify %s
// REQUIRES: plugins, examples

// Test that the MainCallChecker example analyzer plugin loads and runs.

int main();

void caller() {
  main(); // expected-warning {{call to main}}
}
