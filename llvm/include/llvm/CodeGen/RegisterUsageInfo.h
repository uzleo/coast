//==- RegisterUsageInfo.h - Register Usage Informartion Storage -*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
/// \file
/// This pass is required to take advantage of the interprocedural register
/// allocation infrastructure.
///
/// This pass is simple immutable pass which keeps RegMasks (calculated based on
/// actual register allocation) for functions in a module and provides simple
/// API to query this information.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_CODEGEN_PHYSICALREGISTERUSAGEINFO_H
#define LLVM_CODEGEN_PHYSICALREGISTERUSAGEINFO_H

#include "llvm/ADT/DenseMap.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"

namespace llvm {

class PhysicalRegisterUsageInfo : public ImmutablePass {
  virtual void anchor();

public:
  static char ID;

  PhysicalRegisterUsageInfo() : ImmutablePass(ID) {
    PassRegistry &Registry = *PassRegistry::getPassRegistry();
    initializePhysicalRegisterUsageInfoPass(Registry);
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesAll();
  }

  /// To set TargetMachine *, which is used to print
  /// analysis when command line option -print-regusage is used.
  void setTargetMachine(const TargetMachine *TM_) { TM = TM_; }

  bool doInitialization(Module &M) override;

  bool doFinalization(Module &M) override;

  /// To store RegMask for given Function *.
  void storeUpdateRegUsageInfo(const Function *FP,
                               std::vector<uint32_t> RegMask);

  /// To query stored RegMask for given Function *, it will return nullptr if
  /// function is not known.
  const std::vector<uint32_t> *getRegUsageInfo(const Function *FP);

  void print(raw_ostream &OS, const Module *M = nullptr) const override;

private:
  /// A Dense map from Function * to RegMask.
  /// In RegMask 0 means register used (clobbered) by function.
  /// and 1 means content of register will be preserved around function call.
  DenseMap<const Function *, std::vector<uint32_t>> RegMasks;

  const TargetMachine *TM;
};
}

#endif
