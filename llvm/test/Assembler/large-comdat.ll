; RUN: llvm-as < %s | llvm-dis | FileCheck %s

$_ZSt9make_pairIN4llvm16DenseMapIteratorINS0_14PointerIntPairIPKNS0_5ValueELj1ENS0_21PointerLikeTypeTraitsIS5_EEEENS0_19NonLocalPointerInfoENS0_12DenseMapInfoIS8_EENS0_12DenseMapPairIS9_EEEEbESt4pairINSt17__decay_and_stripIT_E6__typeENSG_IT0_E6__typeEESH_SK_ = comdat any

; CHECK: $_ZSt9make_pairIN4llvm16DenseMapIteratorINS0_14PointerIntPairIPKNS0_5ValueELj1ENS0_21PointerLikeTypeTraitsIS5_EEEENS0_19NonLocalPointerInfoENS0_12DenseMapInfoIS8_EENS0_12DenseMapPairIS9_EEEEbESt4pairINSt17__decay_and_stripIT_E6__typeENSG_IT0_E6__typeEESH_SK_ = comdat any

define void @_ZSt9make_pairIN4llvm16DenseMapIteratorINS0_14PointerIntPairIPKNS0_5ValueELj1ENS0_21PointerLikeTypeTraitsIS5_EEEENS0_19NonLocalPointerInfoENS0_12DenseMapInfoIS8_EENS0_12DenseMapPairIS9_EEEEbESt4pairINSt17__decay_and_stripIT_E6__typeENSG_IT0_E6__typeEESH_SK_() comdat {
  ret void
}
