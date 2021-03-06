set(CMAKE_BUILD_TYPE RELEASE CACHE STRING "")
set(CLANG_ENABLE_BOOTSTRAP ON CACHE BOOL "")
set(LLVM_BUILD_EXTERNAL_COMPILER_RT ON CACHE BOOL "")
set(BOOTSTRAP_LLVM_ENABLE_LTO ON CACHE BOOL "")

set(CLANG_BOOTSTRAP_TARGETS
  clang
  check-all
  check-llvm
  check-clang
  test-suite CACHE STRING "")

set(CLANG_BOOTSTRAP_CMAKE_ARGS
  -C ${CMAKE_CURRENT_LIST_DIR}/3-stage-base.cmake
  CACHE STRING "")
