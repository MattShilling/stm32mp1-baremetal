cmake_minimum_required(VERSION 3.10)

project(stm32mp1-baremetal)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 11)

include_directories(
    ${CMAKE_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/third-party
    ${CMAKE_SOURCE_DIR}/third-party/STM32MP1xx_HAL_Driver/Inc
    ${CMAKE_SOURCE_DIR}/third-party/CMSIS/Core_A/Include
    ${CMAKE_SOURCE_DIR}/third-party/CMSIS/Device/ST/STM32MP1xx/Include)

# This is bad. 
# There's gotta be a better way to include different HALs for each project.
if(BUILD_TARGET STREQUAL "mipi_dsi_lcd")
    include_directories(${CMAKE_SOURCE_DIR}/config/mipi_dsi_lcd)
elseif(BUILD_TARGET STREQUAL "audio_processor")
    include_directories(${CMAKE_SOURCE_DIR}/config/audio_processor)
endif()

# Incrementally add these back.
#add_subdirectory(CoreModules)
add_subdirectory(drivers)
#add_subdirectory(stm32hal_patched)
#add_subdirectory(system)
#add_subdirectory(util)