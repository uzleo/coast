// RUN: rm -rf %t
// RUN: %clang_cc1 -fmodules -fimplicit-module-maps -fobjc-arc -I %S/Inputs -fmodules-cache-path=%t %s -verify -DUSE_1 -DUSE_2 -DUSE_3 -DUSE_4
// RUN: %clang_cc1 -fmodules -fimplicit-module-maps -fobjc-arc -I %S/Inputs -fmodules-cache-path=%t %s -verify -DUSE_2 -DUSE_3 -DUSE_4
// RUN: %clang_cc1 -fmodules -fimplicit-module-maps -fobjc-arc -I %S/Inputs -fmodules-cache-path=%t %s -verify -DUSE_3 -DUSE_4
// RUN: %clang_cc1 -fmodules -fimplicit-module-maps -fobjc-arc -I %S/Inputs -fmodules-cache-path=%t %s -verify -DUSE_4

// expected-note@Inputs/def.h:5 0-1{{previous}}
// expected-note@Inputs/def.h:16 0-1{{previous}}
// expected-note@Inputs/def-include.h:11 0-1{{previous}}

@class Def;
Def *def;
class Def2; // expected-note 0-1{{forward decl}}
Def2 *def2;
namespace Def3NS { class Def3; } // expected-note 0-1{{forward decl}}
Def3NS::Def3 *def3;

@interface Unrelated
- defMethod;
@end

@import decldef;
#ifdef USE_1
A *a1; // expected-error{{declaration of 'A' must be imported from module 'decldef.Def'}}
B *b1;
#define USED
#endif
@import decldef.Decl;

A *a2;
B *b;

void testA(A *a) {
#ifdef USE_2
  a->ivar = 17;
  #ifndef USED
  // expected-error@-2{{definition of 'A' must be imported from module 'decldef.Def' before it is required}}
  #define USED
  #endif
#endif
}

void testB() {
#ifdef USE_3
  B b;
  #ifndef USED
  // expected-error@-2{{definition of 'B' must be imported from module 'decldef.Def' before it is required}}
  #define USED
  #endif
#endif
}

void testDef() {
  [def defMethod];
}

void testDef2() {
#ifdef USE_4
  def2->func();
  def3->func();
  #ifndef USED
  // expected-error@-3 {{definition of 'Def2' must be imported}}
  #define USED
  #endif
#endif
}
