set(LLVM_TARGET_DEFINITIONS Options.td)
tablegen(LLVM Options.inc -gen-opt-parser-defs)
add_public_tablegen_target(LibOptionsTableGen)

add_llvm_library(LLVMLibDriver
  LibDriver.cpp
  )
add_dependencies(LLVMLibDriver LibOptionsTableGen)
