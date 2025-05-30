# Copyright 2022-2023 The Khronos Group Inc.
# Copyright 2022-2023 RasterGrid Kft.
# SPDX-License-Identifier: Apache-2.0

find_package(Python3 REQUIRED COMPONENTS Interpreter)

enable_testing()

set(CASELIST
    tests/tools/cli_errors.json
    tests/tools/help.json

    tests/info/cli_errors.json
    tests/info/help.json
    tests/info/invalid_file.json
    tests/info/sample.json
    tests/info/stdin.json
    tests/info/unicode_filenames.json

    tests/validate/cli_errors.json
    tests/validate/help.json
    tests/validate/stdin.json
    tests/validate/unicode_filenames.json

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
    tests/validate/error_3027_IndexSGDNotApplicable.json
    tests/validate/error_3028_IndexDFDInvalidLength.json

    tests/validate/error_3101_InvalidSupercompressionGLTFBU.json
    tests/validate/error_3102_InvalidTextureTypeGLTFBU.json
    tests/validate/error_3103_InvalidPixelWidthHeightGLTFBU.json
    tests/validate/error_3104_InvalidLevelCountGLTFBU.json

    tests/validate/error_4001_IncorrectIndexOrder.json
    tests/validate/error_4002_IncorrectLevelOrder.json
    tests/validate/error_4003_IncorrectByteOffsetUnaligned.json
    tests/validate/error_4004_IncorrectByteOffset.json
    tests/validate/error_4005_IncorrectByteLength.json
    tests/validate/error_4006_IncorrectUncompressedByteLength.json
    tests/validate/error_4007_NonZeroUBLForBLZE.json
    tests/validate/error_4008_UncompressedByteLengthMismatch.json
    tests/validate/error_4009_ZeroUncompressedLength.json
    tests/validate/error_4010_InvalidUncompressedLength.json

    tests/validate/error_5006_DecompressChecksumError.json

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
    tests/validate/error_6017_IncorrectModelFor422.json
    tests/validate/error_6018_IncorrectModelForBLZE.json
    tests/validate/error_6019_InvalidColorPrimaries.json
    tests/validate/error_6020_InvalidTexelBlockDimension.json
    tests/validate/error_6021_BytesPlanesMismatch.json
    tests/validate/error_6023_BytesPlane0Zero.json
    tests/validate/error_6024_MultiplaneFormatsNotSupported.json
    tests/validate/error_6025_SampleCountMismatch.json
    tests/validate/error_6026_InvalidSampleCount.json
    tests/validate/error_6027_ZeroSamples.json
    tests/validate/error_6028_FormatMismatch.json
    tests/validate/warning_6029_TooManySamples.json
    tests/validate/warning_6030_BytesPlanesUnsized.json

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

    tests/validate/error_6301_IncorrectModelGLTFBU.json
    tests/validate/error_6302_IncompatibleModelGLTFBU.json
    tests/validate/error_6303_InvalidChannelGLTFBU.json
    tests/validate/error_6304_InvalidColorSpaceGLTFBU.json

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

    tests/validate/error_7201_KTXswizzleInvalidGLTFBU.json
    tests/validate/error_7202_KTXorientationInvalidGLTFBU.json

    tests/validate/error_8101_BLZESizeTooSmallHeader.json
    tests/validate/error_8102_BLZESizeIncorrect.json
    tests/validate/error_8103_BLZEExtendedByteLengthNotZero.json
    tests/validate/error_8104_BLZEInvalidImageFlagBit.json
    tests/validate/error_8105_BLZENoAnimationSequencesPFrame.json
    tests/validate/error_8106_BLZEZeroRGBLength.json
    tests/validate/error_8107_BLZEInvalidRGBSlice.json
    tests/validate/error_8108_BLZEInvalidAlphaSlice.json
    tests/validate/error_8109_BLZEDFDMismatchAlpha.json
    tests/validate/error_8110_BLZEDFDMismatchNoAlpha.json

    tests/extract/cli_errors.json
    tests/extract/exr_2d.json
    tests/extract/help.json
    tests/extract/png_2d.json
    tests/extract/raw_all_1d.json
    tests/extract/raw_all_1d_array.json
    tests/extract/raw_all_1d_array_mip.json
    tests/extract/raw_all_1d_mip.json
    tests/extract/raw_all_2d.json
    tests/extract/raw_all_2d_array.json
    tests/extract/raw_all_2d_array_mip.json
    tests/extract/raw_all_2d_mip.json
    tests/extract/raw_all_3d.json
    tests/extract/raw_all_3d_mip.json
    tests/extract/raw_all_cube.json
    tests/extract/raw_all_cube_array.json
    tests/extract/raw_all_cube_array_mip.json
    tests/extract/raw_all_cube_mip.json
    tests/extract/raw_select_1d.json
    tests/extract/raw_select_1d_array.json
    tests/extract/raw_select_1d_array_mip.json
    tests/extract/raw_select_1d_mip.json
    tests/extract/raw_select_2d.json
    tests/extract/raw_select_2d_array.json
    tests/extract/raw_select_2d_array_mip.json
    tests/extract/raw_select_2d_mip.json
    tests/extract/raw_select_3d.json
    tests/extract/raw_select_3d_bc.json
    tests/extract/raw_select_3d_depthall.json
    tests/extract/raw_select_3d_mip.json
    tests/extract/raw_select_3d_mip_depthall.json
    tests/extract/raw_select_cube.json
    tests/extract/raw_select_cube_array.json
    tests/extract/raw_select_cube_array_mip.json
    tests/extract/raw_select_cube_mip.json
    tests/extract/raw_select_uri_2d_array_mip.json
    tests/extract/raw_select_uri_2d_array_mip_multi.json
    tests/extract/raw_select_uri_cube.json
    tests/extract/raw_transcode_blze.json
    tests/extract/raw_transcode_uastc.json
    tests/extract/raw_uastc_zlib.json
    tests/extract/raw_uastc_zstd.json
    tests/extract/raw_zlib.json
    tests/extract/raw_zstd.json
    tests/extract/stdin.json
    tests/extract/stdout.json
    tests/extract/unicode_filenames.json

    tests/create/astc_params.json
    tests/create/3d_with_1_depth.json
    tests/create/array_with_1_layer.json
    tests/create/basic_exr.json
    tests/create/basic_png.json
    tests/create/cli_errors.json
    tests/create/colorspaces_assign_and_convert_tf_linear.json
    tests/create/colorspaces_assign_and_convert_tf_srgb.json
    tests/create/colorspaces_assign_tf_linear.json
    tests/create/colorspaces_assign_tf_nonlinear.json
    tests/create/colorspaces_assign_tf_srgb.json
    tests/create/colorspaces_assign_tf_raw.json
    tests/create/colorspaces_assign_primaries_exr.json
    tests/create/colorspaces_assign_primaries_png.json
    tests/create/colorspaces_assign_primaries_raw.json
    tests/create/colorspaces_combinations.json
    tests/create/colorspaces_convert_tf_linear.json
    tests/create/colorspaces_convert_tf_srgb.json
    tests/create/colorspaces_convert_primaries_exr.json
    tests/create/colorspaces_convert_primaries_png.json
    tests/create/colorspaces_error_assign_tf_nonsrgb.json
    tests/create/colorspaces_error_convert_tf_linear.json
    tests/create/colorspaces_error_exr_primaries_mismatch.json
    tests/create/colorspaces_error_png_primaries_mismatch.json
    tests/create/colorspaces_error_png_transfer_mismatch.json
    tests/create/colorspaces_error_png_unknown_icc.json
    tests/create/colorspaces_error_srgb_tf.json
    tests/create/colorspaces_error_unknown_icc.json
    tests/create/colorspaces_error_unsupported_conversion_from_tf.json
    tests/create/colorspaces_error_unsupported_conversion_to_tf.json
    tests/create/colorspaces_error_assign_primaries_none_convert_primaries.json
    tests/create/colorspaces_warning_exr_primaries_mismatch.json
    tests/create/colorspaces_warning_png_primaries_mismatch.json
    tests/create/colorspaces_warning_png_transfer_mismatch.json
    tests/create/colorspaces_exr.json
    tests/create/colorspaces_png.json
    tests/create/colorspaces_png_hdr.json
    tests/create/compare.json
    tests/create/encode_blze.json
    tests/create/encode_blze_params.json
    tests/create/encode_error_blze_zstd_zlib.json
    tests/create/encode_error_codec.json
    tests/create/encode_error_format.json
    tests/create/encode_uastc.json
    tests/create/encode_uastc_params.json
    tests/create/fewer_components_exr.json
    tests/create/fewer_components_png.json
    tests/create/generate_mipmap.json
    tests/create/normalize.json
    tests/create/help.json
    tests/create/image_slices.json
    tests/create/input_swizzle.json
    tests/create/line_order_exr.json
    tests/create/raw_1d.json
    tests/create/raw_1d_array.json
    tests/create/raw_1d_array_mip.json
    tests/create/raw_1d_mip.json
    tests/create/raw_2d.json
    tests/create/raw_2d_array.json
    tests/create/raw_2d_array_mip.json
    tests/create/raw_2d_mip.json
    tests/create/raw_3d.json
    tests/create/raw_3d_bc.json
    tests/create/raw_3d_mip.json
    tests/create/raw_cube.json
    tests/create/raw_cube_array.json
    tests/create/raw_cube_array_mip.json
    tests/create/raw_cube_mip.json
    tests/create/raw_non_convertable.json
    tests/create/raw_zlib.json
    tests/create/raw_zstd.json
    tests/create/runtime_mipmap.json
    tests/create/sample_exr.json
    tests/create/sample_png.json
    tests/create/sample_zlib.json
    tests/create/sample_zstd.json
    tests/create/stdin.json
    tests/create/stdout.json
    tests/create/texcoord_origin.json
    tests/create/unicode_filenames.json
    tests/create/warn_fail_texcoord_origin.json
    tests/create/resize_scale.json
    tests/create/resize_scale_mip_levels.json

    tests/encode/compare.json
    tests/encode/encode_blze.json
    tests/encode/encode_blze_params.json
    tests/encode/encode_error_blze_input.json
    tests/encode/encode_error_blze_zstd_zlib.json
    tests/encode/encode_error_codec.json
    tests/encode/encode_error_format.json
    tests/encode/encode_error_invalid.json
    tests/encode/encode_error_normal_mode.json
    tests/encode/encode_error_too_many_filenames.json
    tests/encode/encode_astc.json
    tests/encode/encode_astc_params.json
    tests/encode/encode_astc_bad_format.json
    tests/encode/encode_astc_bad_astc_format.json
    tests/encode/encode_uastc.json
    tests/encode/encode_uastc_params.json
    tests/encode/help.json
    tests/encode/stdin.json
    tests/encode/stdout.json
    tests/encode/unicode_filenames.json

    tests/transcode/help.json
    tests/transcode/stdin.json
    tests/transcode/stdout.json
    tests/transcode/unicode_filenames.json
    tests/transcode/transcode_blze.json
    tests/transcode/transcode_error_invalid.json
    tests/transcode/transcode_error_not_transcodable.json
    tests/transcode/transcode_error_target.json
    tests/transcode/transcode_error_too_many_filenames.json
    tests/transcode/transcode_uastc.json
    tests/transcode/transcode_zlib.json
    tests/transcode/transcode_zstd.json

    tests/compare/help.json
    tests/compare/cli_errors.json
    tests/compare/invalid_file1.json
    tests/compare/invalid_file2.json
    tests/compare/invalid_file_both.json
    tests/compare/unicode_filenames.json
    tests/compare/allow_invalid_input1.json
    tests/compare/allow_invalid_input2.json
    tests/compare/allow_invalid_input_both.json
    tests/compare/allow_invalid_input_positive.json
    tests/compare/header_identifier.json
    tests/compare/header_format.json
    tests/compare/header_dimensions.json
    tests/compare/header_supercompression.json
    tests/compare/ignore_format_header.json
    tests/compare/ignore_supercompression.json
    tests/compare/index_dfd.json
    tests/compare/index_kvd.json
    tests/compare/index_sgd.json
    tests/compare/level_index.json
    tests/compare/ignore_index_all.json
    tests/compare/ignore_index_level.json
    tests/compare/ignore_index_none.json
    tests/compare/ignore_dfd_all.json
    tests/compare/ignore_dfd_all_except_color_space.json
    tests/compare/ignore_dfd_unknown.json
    tests/compare/ignore_dfd_extended.json
    tests/compare/ignore_dfd_none.json
    tests/compare/ignore_bdfd_bytesplane.json
    tests/compare/ignore_metadata_all.json
    tests/compare/ignore_metadata_none.json
    tests/compare/ignore_metadata_keys.json
    tests/compare/ignore_sgd_all.json
    tests/compare/ignore_sgd_unknown.json
    tests/compare/ignore_sgd_payload.json
    tests/compare/ignore_sgd_none.json

    tests/compare/content_match_2d.json
    tests/compare/content_match_3d.json
    tests/compare/content_ignore_2d.json
    tests/compare/content_ignore_3d.json
    tests/compare/content_raw_2d.json
    tests/compare/content_raw_3d.json
    tests/compare/content_image_2d.json
    tests/compare/content_image_3d.json
    tests/compare/content_per_pixel_output_2d.json
    tests/compare/content_per_pixel_output_3d.json
    tests/compare/content_supercomp.json

    tests/deflate/cli_errors.json
    tests/deflate/deflate_error_blze_not_deflatable.json
    tests/deflate/help.json
    tests/deflate/stdin.json
    tests/deflate/stdout.json
    tests/deflate/unicode_filenames.json

    tests/help/cli_errors.json
    tests/help/help.json
)

set(LEGACY_CASELIST
    legacy_tests/ktx2check/unicode_filenames.json
    legacy_tests/ktxinfo/unicode_filenames.json
    legacy_tests/ktxsc/unicode_filenames.json
    legacy_tests/toktx/unicode_filenames.json
)

set(CASE_REGEN_GOLDEN_OUTPUTS)

if(NOT DEFINED KTX_TOOLS_PATH)
    message(FATAL_ERROR "KTX_TOOLS_PATH not defined")
endif()
if(NOT DEFINED KTX_DIFF_PATH)
    message(FATAL_ERROR "KTX_DIFF_PATH not defined")
endif()

# Even with gcc, zlib yields a slightly different compression
# result on arm64. Yet to be investigated.
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CPU_ARCHITECTURE STREQUAL arm64)
    set(CLITEST_ARGS "--primary")
else()
    set(CLITEST_ARGS "")
endif()

# If this is a function, for reasons I have yet to understand,
# add_custom_command() does nothing. All variables have the expected
# values in each case.
macro(add_test_case CASE_FILE PREFIX SUITE_NAME TOOLS_PATH)
    get_filename_component(CASE_DIR ${CASE_FILE} DIRECTORY)
    get_filename_component(CASE_NAME ${CASE_FILE} NAME_WE)
    string(REGEX REPLACE "^${PREFIX}/" "${SUITE_NAME}/" CASE_TRIMMED_DIR "${CASE_DIR}/")
    string(REPLACE "/" "." CASE_GROUP "${CASE_TRIMMED_DIR}")
    set(FULL_CASE_NAME "${CASE_GROUP}${CASE_NAME}")
    list(APPEND CASE_REGEN_GOLDEN_OUTPUTS ${CASE_FILE})
    add_custom_command(
        OUTPUT ${CASE_FILE}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMAND ${Python3_EXECUTABLE} clitest.py ${CASE_FILE} ${CLITEST_ARGS} --executable-path "${TOOLS_PATH}" --ktxdiff-path "${KTX_DIFF_PATH}" --regen-golden)
    add_test(NAME ${FULL_CASE_NAME}
        COMMAND ${Python3_EXECUTABLE} clitest.py ${CASE_FILE} ${CLITEST_ARGS} --executable-path "${TOOLS_PATH}" --ktxdiff-path "${KTX_DIFF_PATH}"
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
endmacro()

foreach(CASE_FILE ${CASELIST})
    add_test_case(${CASE_FILE} tests ktxToolsTest ${KTX_TOOLS_PATH})
endforeach()

foreach(CASE_FILE ${LEGACY_CASELIST})
    add_test_case(${CASE_FILE} legacy_tests LegacyToolsTest ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/)
endforeach()

add_custom_target(clitests_regen_golden
    DEPENDS ${CASE_REGEN_GOLDEN_OUTPUTS})
