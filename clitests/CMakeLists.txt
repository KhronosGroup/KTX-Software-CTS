# Copyright 2022-2023 The Khronos Group Inc.
# Copyright 2022-2023 RasterGrid Kft.
# SPDX-License-Identifier: Apache-2.0

find_package(PythonInterp 3 REQUIRED)

enable_testing()

set(CASELIST
    tests/info/sample_text.json
    tests/info/sample_json.json
    tests/info/sample_mini.json
    tests/validate/fatal_1003_UnexpectedEOF.json
    tests/validate/fatal_2001_NotKTX2.json
    tests/validate/error_3001_ProhibitedFormat.json
    tests/validate/error_3002_InvalidFormat.json
    tests/validate/warning_3003_UnknownFormat.json
    tests/validate/error_3004_VkFormatAndBasis.json
    tests/validate/error_3005_TypeSizeNotOne.json
    tests/validate/error_3006_WidthZero.json
    tests/validate/error_3007_BlockCompressedNoHeight.json
    tests/validate/error_3008_CubeHeightWidthMismatch.json
    tests/validate/error_3009_DepthNoHeight.json
    tests/validate/error_3010_DepthBlockCompressedNoDepth.json
    tests/validate/error_3011_DepthStencilFormatWithDepth.json
    tests/validate/error_3013_CubeWithDepth.json
    tests/validate/warning_3014_ThreeDArray.json
    tests/validate/error_3015_InvalidFaceCount.json
    tests/validate/error_3016_TooManyMipLevels.json
    tests/validate/error_3017_BlockCompressedNoLevel.json
    tests/validate/warning_3018_VendorSupercompression.json
    tests/validate/error_3019_InvalidSupercompression.json
    tests/validate/error_3020_IndexDFDMissing.json
    tests/validate/error_3021_IndexDFDInvalidOffset.json)

set(CASE_REGEN_GOLDEN_COMMANDS)

if(NOT DEFINED KTX_TOOLS_PATH)
    message(FATAL_ERROR "KTX_TOOLS_PATH not defined")
endif()

foreach(CASE_FILE ${CASELIST})
    get_filename_component(CASE_DIR ${CASE_FILE} DIRECTORY)
    get_filename_component(CASE_NAME ${CASE_FILE} NAME_WE)
    string(REGEX REPLACE "^tests/" "ktxToolTests/" CASE_TRIMMED_DIR "${CASE_DIR}/")
    string(REPLACE "/" "." CASE_GROUP "${CASE_TRIMMED_DIR}")
    set(FULL_CASE_NAME "${CASE_GROUP}${CASE_NAME}")

    list(APPEND CASE_REGEN_GOLDEN_COMMANDS
        COMMAND ${PYTHON_EXECUTABLE} clitest.py ${CASE_FILE} --executable-path ${KTX_TOOLS_PATH} --regen-golden)

    add_test(NAME ${FULL_CASE_NAME}
        COMMAND ${PYTHON_EXECUTABLE} clitest.py ${CASE_FILE} --executable-path ${KTX_TOOLS_PATH}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
endforeach()

add_custom_target(clitests_regen_golden
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    ${CASE_REGEN_GOLDEN_COMMANDS})
