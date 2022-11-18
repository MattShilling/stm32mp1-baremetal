set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(TOOLCHAIN arm-none-eabi)
set(TOOLCHAIN_PREFIX "/usr/local/arm-gnu-toolchain-12.2.mpacbti-bet1-x86_64-arm-none-eabi")
set(TOOLCHAIN_BIN_DIR ${TOOLCHAIN_PREFIX}/bin)
set(TOOLCHAIN_INC_DIR ${TOOLCHAIN_PREFIX}/${TOOLCHAIN}/include)
set(TOOLCHAIN_LIB_DIR ${TOOLCHAIN_PREFIX}/${TOOLCHAIN}/lib)

# Perform compiler test with static library
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(OBJECT_GEN_FLAGS "-Os \
-fno-builtin \
-Wall \
-ffunction-sections \
-fdata-sections \
-fomit-frame-pointer \
-mthumb \
-mfpu=neon-vfpv4 \
-mfloat-abi=hard \
-march=armv7ve \
-mcpu=cortex-a7 \
-mtune=cortex-a7")


set(CMAKE_C_FLAGS "${OBJECT_GEN_FLAGS} \
-DUSE_HAL_DRIVER \
-DUSE_FULL_LL_DRIVER \
-DSTM32MP157Cxx \
-DSTM32MP1 \
-DCORE_CA7 \
-g2 \
-fno-common \
-mno-unaligned-access \
-funsafe-math-optimizations \
-mvectorize-with-neon-quad \
-mlittle-endian \
-fdata-sections -ffunction-sections \
-nostartfiles \
-ffreestanding" 
CACHE INTERNAL "C Compiler options")


set(CMAKE_CXX_FLAGS "${OBJECT_GEN_FLAGS} ${CMAKE_C_FLAGS} \
-std=c++2a \
-fno-rtti \
-fno-exceptions \
-fno-unwind-tables \
-ffreestanding \
-fno-threadsafe-statics \
-mno-unaligned-access \
-Werror=return-type \
-Wdouble-promotion \
-Wno-register \
-Wno-volatile"
CACHE INTERNAL "C++ Compiler options")

set(CMAKE_ASM_FLAGS "${OBJECT_GEN_FLAGS}" CACHE INTERNAL "ASM Compiler options")


#---------------------------------------------------------------------------------------
# Set compilers
#---------------------------------------------------------------------------------------
set(CMAKE_C_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-gcc CACHE INTERNAL "C Compiler")
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-g++ CACHE INTERNAL "C++ Compiler")
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-as CACHE INTERNAL "ASM Compiler")

set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_PREFIX}/${${TOOLCHAIN}} ${CMAKE_PREFIX_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)