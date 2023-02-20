# Copyright 2022-2023 The Khronos Group Inc.
# Copyright 2022-2023 RasterGrid Kft.
# SPDX-License-Identifier: Apache-2.0

find_package(PythonInterp 3 REQUIRED)

enable_testing()

set(CASELIST
    tests/info/sample_text.json
    tests/info/sample_json.json
    tests/info/sample_mini.json
    tests/info/MissingFile.json

    #tests/validate/valid.json

    tests/validate/fatal_1001_FileOpen.json
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
    tests/validate/error_3012_TypeSizeMismatch.json
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
    #tests/validate/error_3027_IndexSGDNotApplicable.json
    tests/validate/error_3028_IndexDFDInvalidLength.json

    tests/validate/error_4001_IncorrectIndexOrder.json
    tests/validate/error_4002_IncorrectLevelOrder.json
    tests/validate/error_4003_IncorrectByteOffsetUnaligned.json
    tests/validate/error_4004_IncorrectByteOffset.json
    tests/validate/error_4005_IncorrectByteLength.json
    tests/validate/error_4006_IncorrectUncompressedByteLength.json
    tests/validate/error_4007_NonZeroUBLForBLZE.json
    #tests/validate/error_4008_?.json
    tests/validate/error_4009_ZeroUncompressedLength.json
    tests/validate/error_4010_InvalidUncompressedLength.json

    tests/validate/error_6001_SizeMismatch.json
    tests/validate/warning_6002_TooManyDFDBlocks.json
    tests/validate/warning_6003_UnknownDFDBlock.json
    tests/validate/error_6004_NotEnoughDataForBlockHeader.json
    tests/validate/warning_6005_MultipleBDFD.json
    tests/validate/error_6006_DescriptorBlockSizeTooSmall.json
    tests/validate/error_6007_DescriptorBlockSizeTooBig.json
    tests/validate/error_6008_MissingBDFD.json
    tests/validate/error_6009_BasicDescriptorBlockSizeInvalid.json
    tests/validate/error_6010_BasicDescriptorBlockSizeTooSmall.json
    tests/validate/error_6011_BasicVersionNotSupported.json
    tests/validate/error_6012_BasicInvalidTransferFunction.json
    tests/validate/error_6013_BasicSRGBMismatch.json
    tests/validate/error_6014_BasicNotSRGBMismatch.json
    tests/validate/error_6015_IncorrectModelForRGB.json
    tests/validate/error_6016_IncorrectModelForBlock.json
    #tests/validate/error_6017_IncorrectModelFor422.json
    tests/validate/error_6018_IncorrectModelForBLZE.json
    tests/validate/error_6019_InvalidColorPrimaries.json
    tests/validate/error_6020_InvalidTexelBlockDimension.json
    tests/validate/error_6021_BytesPlanesMismatch.json
    tests/validate/error_6022_BytesPlanesNotUnsized.json
    tests/validate/error_6023_BytesPlane0Zero.json
    tests/validate/error_6024_MultiplaneFormatsNotSupported.json
    tests/validate/error_6025_SampleCountMismatch.json
    tests/validate/error_6026_InvalidSampleCount.json
    tests/validate/error_6027_ZeroSamples.json
    tests/validate/error_6028_FormatMismatch.json

    tests/validate/error_6101_InvalidChannelForModel.json
    tests/validate/error_6102_InvalidBitOffsetForUASTC.json
    tests/validate/error_6103_InvalidBitOffsetForBLZE.json
    tests/validate/error_6104_InvalidBitLengthForUASTC.json
    tests/validate/error_6105_InvalidBitLengthForBLZE.json
    tests/validate/error_6106_InvalidLower.json
    tests/validate/error_6107_InvalidUpper.json

    tests/validate/error_6203_InterpretDFDMixedChannels.json
    tests/validate/error_6204_InterpretDFDMultisample.json
    tests/validate/error_6205_InterpretDFDNonTrivialEndianness.json

    tests/validate/warning_7001_TooManyEntries.json
    tests/validate/error_7002_NotEnoughDataForAnEntry.json
    tests/validate/error_7003_KeyAndValueByteLengthTooLarge.json
    tests/validate/error_7004_KeyAndValueByteLengthTooSmall.json
    tests/validate/error_7005_KeyMissingNullTerminator.json
    tests/validate/error_7006_KeyForbiddenBOM.json
    tests/validate/error_7007_KeyInvalidUTF8.json
    tests/validate/error_7008_SizesDontAddUp.json
    tests/validate/error_7009_UnknownReservedKey.json
    tests/validate/warning_7010_CustomMetadata.json
    tests/validate/error_7011_PaddingNotZero.json
    tests/validate/error_7012_OutOfOrder.json
    tests/validate/error_7013_DuplicateKey.json
    tests/validate/error_7014_KeyEmpty.json

    tests/validate/error_7101_KTXcubemapIncompleteInvalidBitSet.json
    tests/validate/warning_7102_KTXcubemapIncompleteAllBitsSet.json
    tests/validate/error_7103_KTXcubemapIncompleteNoBitSet.json
    tests/validate/error_7104_KTXcubemapIncompleteIncompatibleLayerCount.json
    tests/validate/error_7105_KTXcubemapIncompleteWithFaceCountNot1.json
    tests/validate/error_7106_KTXcubemapIncompleteInvalidSize.json
    tests/validate/error_7107_KTXorientationMissingNull.json
    tests/validate/error_7108_KTXorientationIncorrectDimension.json
    tests/validate/error_7109_KTXorientationInvalidValue.json
    tests/validate/error_7110_KTXglFormatInvalidSize.json
    tests/validate/error_7111_KTXglFormatWithVkFormat.json
    tests/validate/error_7112_KTXglFormatInvalidValueForCompressed.json
    tests/validate/error_7113_KTXdxgiFormatInvalidSize.json
    tests/validate/error_7114_KTXdxgiFormatWithVkFormat.json
    tests/validate/error_7115_KTXmetalPixelFormatInvalidSize.json
    tests/validate/error_7116_KTXmetalPixelFormatWithVkFormat.json
    tests/validate/error_7117_KTXswizzleMissingNull.json
    tests/validate/error_7118_KTXswizzleInvalidSize.json
    tests/validate/error_7119_KTXswizzleInvalidValue.json
    tests/validate/warning_7121_KTXswizzleWithDepthOrStencil.json
    tests/validate/error_7122_KTXwriterMissingNull.json
    tests/validate/error_7123_KTXwriterInvalidUTF8.json
    tests/validate/error_7124_KTXwriterRequiredButMissing.json
    tests/validate/warning_7125_KTXwriterMissing.json
    tests/validate/error_7126_KTXwriterScParamsMissingNull.json
    tests/validate/error_7127_KTXwriterScParamsInvalidUTF8.json
    tests/validate/error_7128_KTXanimDataInvalidSize.json
    tests/validate/error_7129_KTXanimDataNotArray.json
    tests/validate/error_7130_KTXanimDataWithCubeIncomplete.json
    tests/validate/error_7131_KTXastcDecodeModeMissingNull.json
    tests/validate/error_7132_KTXastcDecodeModeInvalidValue.json
    tests/validate/error_7133_KTXastcDecodeModeunorm8NotLDR.json
    tests/validate/warning_7134_KTXastcDecodeModeNotASTC.json
    tests/validate/warning_7135_KTXastcDecodeModeWithsRGB.json
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
