//===-------- llvm/GlobalAlias.h - GlobalAlias class ------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the declaration of the GlobalAlias class, which
// represents a single function or variable alias in the IR.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_IR_GLOBALALIAS_H
#define LLVM_IR_GLOBALALIAS_H

#include "llvm/ADT/ilist_node.h"
#include "llvm/IR/GlobalIndirectSymbol.h"

namespace llvm {

class Twine;
class Module;
template <typename ValueSubClass> class SymbolTableListTraits;

class GlobalAlias : public GlobalIndirectSymbol,
                    public ilist_node<GlobalAlias> {
  friend class SymbolTableListTraits<GlobalAlias>;
  void operator=(const GlobalAlias &) = delete;
  GlobalAlias(const GlobalAlias &) = delete;

  void setParent(Module *parent);

  GlobalAlias(Type *Ty, unsigned AddressSpace, LinkageTypes Linkage,
              const Twine &Name, Constant *Aliasee, Module *Parent);

public:
  /// If a parent module is specified, the alias is automatically inserted into
  /// the end of the specified module's alias list.
  static GlobalAlias *create(Type *Ty, unsigned AddressSpace,
                             LinkageTypes Linkage, const Twine &Name,
                             Constant *Aliasee, Module *Parent);

  // Without the Aliasee.
  static GlobalAlias *create(Type *Ty, unsigned AddressSpace,
                             LinkageTypes Linkage, const Twine &Name,
                             Module *Parent);

  // The module is taken from the Aliasee.
  static GlobalAlias *create(Type *Ty, unsigned AddressSpace,
                             LinkageTypes Linkage, const Twine &Name,
                             GlobalValue *Aliasee);

  // Type, Parent and AddressSpace taken from the Aliasee.
  static GlobalAlias *create(LinkageTypes Linkage, const Twine &Name,
                             GlobalValue *Aliasee);

  // Linkage, Type, Parent and AddressSpace taken from the Aliasee.
  static GlobalAlias *create(const Twine &Name, GlobalValue *Aliasee);

  /// removeFromParent - This method unlinks 'this' from the containing module,
  /// but does not delete it.
  ///
  void removeFromParent() override;

  /// eraseFromParent - This method unlinks 'this' from the containing module
  /// and deletes it.
  ///
  void eraseFromParent() override;

  /// These methods retrieve and set alias target.
  void setAliasee(Constant *Aliasee);
  const Constant *getAliasee() const {
    return getIndirectSymbol();
  }
  Constant *getAliasee() {
    return getIndirectSymbol();
  }

  static bool isValidLinkage(LinkageTypes L) {
    return isExternalLinkage(L) || isLocalLinkage(L) ||
      isWeakLinkage(L) || isLinkOnceLinkage(L);
  }

  // Methods for support type inquiry through isa, cast, and dyn_cast:
  static inline bool classof(const Value *V) {
    return V->getValueID() == Value::GlobalAliasVal;
  }
};

} // End llvm namespace

#endif
