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
    tests/validate/error_3021_IndexDFDInvalidOffset.json
    tests/validate/error_3022_IndexKVDInvalidOffset.json
    tests/validate/error_3023_IndexKVDOffsetWithoutLength.json
    tests/validate/error_3024_IndexSGDInvalidOffset.json
    tests/validate/error_3025_IndexSGDOffsetWithoutLength.json
    tests/validate/error_3026_IndexSGDMissing.json

    tests/validate/error_6001_SizeMismatch.json
    tests/validate/error_6002_TooManyDFDBlocks.json
    tests/validate/warning_6003_UnknownDFDBlock.json
    tests/validate/error_6004_NotEnoughDataForBlockHeader.json
    tests/validate/warning_6005_MultipleBDFD.json
    tests/validate/error_6006_DescriptorBlockSizeTooSmall.json
    tests/validate/error_6007_DescriptorBlockSizeTooBig.json
    tests/validate/error_6008_MissingBDFD.json
    tests/validate/error_6009_BasicDescriptorBlockSizeInvalid.json
    tests/validate/error_6010_BasicDescriptorBlockSizeTooSmall.json

    tests/validate/error_7001_TooManyEntries.json
    tests/validate/error_7002_NotEnoughDataForAnEntry.json
    tests/validate/error_7003_KeyAndValueByteLengthTooLarge.json
    tests/validate/error_7004_KeyAndValueByteLengthTooSmall.json
    tests/validate/error_7005_KeyMissingNullTerminator.json
    tests/validate/error_7006_KeyForbiddenBOM.json
    tests/validate/warning_7007_KeyInvalidUTF8.json
    tests/validate/error_7008_SizesDontAddUp.json
    tests/validate/error_7009_UnknownReservedKey.json
    tests/validate/warning_7010_CustomMetadata.json
    tests/validate/error_7011_PaddingNotZero.json
    tests/validate/error_7012_OutOfOrder.json
    tests/validate/error_7013_DuplicateKey.json
    tests/validate/error_7014_KeyEmpty.json

    tests/validate/error_7100_KTXcubemapIncompleteInvalidSize.json
    tests/validate/error_7101_KTXcubemapIncompleteInvalidBitSet.json
    tests/validate/warning_7102_KTXcubemapIncompleteAllBitSet.json
    tests/validate/error_7103_KTXcubemapIncompleteNoBitSet.json
    tests/validate/error_7104_KTXcubemapIncompleteIncompatibleLayerCount.json
    tests/validate/error_7105_KTXcubemapIncompleteWithFaceCountNot1.json
)

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
