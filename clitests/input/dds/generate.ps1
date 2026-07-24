# Copyright 2023 The Khronos Group Inc.
# SPDX-License-Identifier: Apache-2.0

# Generate DDS files from input PNG files using texconv/texassemble DirectXTex
# tools (official Microsoft tools for generating DDS textures).

# DirectXTex tools only compile/work on Windows
# Before running this script, you have to:
#  - Install texconv via: winget install Microsoft.DirectXTex.Texconv
#       see: https://github.com/microsoft/DirectXTex/wiki/Texconv
#  - Install texassemble via: winget install Microsoft.DirectXTex.Texassemble
#       see: https://github.com/microsoft/DirectXTex/wiki/Texassemble
#
# Notes:
#   - texconv does not support writing a named file. You have to provide it with output dir (because mipmaps)
#   - texconv does not support EXR input files
#   - texconv does not support R8G8B8_UNORM/SRGB (RGB no alpha)
#   - texassemble does not support encoding to BC1-BC7 (it makes sense, BC1-BC7 only supports 2D textures)
#   - texassemble does not support mipmap generation (you have to provide it with mipmaps)

# So that we can chain commands using `;` and only run subsequent commands if previous ones succeed
$ErrorActionPreference="Stop"

# Path to CTS inputs from KTX-Software
$INPUT_DIR="KTX-Software\tests\cts\clitests\input"

# Compute max number of mip levels for given dimensions
# [Math]::Log2 doesn't work hence why the division below
function Get-Max-Miplevels {
 param([int]$w, [int]$h, [int]$d)
 [int]([Math]::Log([Math]::Min([Math]::Min($w, $h), $d)) / [Math]::Log(2)) + 1
}

function Get-Max-Miplevels {
 param([int]$w, [int]$h)
 [int]([Math]::Log([Math]::Min($w, $h)) / [Math]::Log(2)) + 1
}

# DDS uncompressed 2D textures
texconv -nologo -y -m 1 -f R8_UNORM -ft dds ${INPUT_DIR}\png\r8_unorm_bc4.png -o .; Move-Item -Force -Path r8_unorm_bc4.dds -Destination valid_compressed_R8_UNORM_40x40.dds
texconv -nologo -y -m 1 -f R8G8_UNORM -ft dds ${INPUT_DIR}\png\rg8_unorm_bc5.png -o .; Move-Item -Force -Path rg8_unorm_bc5.dds -Destination valid_compressed_R8G8_UNORM_40x40.dds
texconv -nologo -y -m 1 -f R8G8B8A8_UNORM -ft dds ${INPUT_DIR}\png\rgba8_unorm_bc7.png -o .; Move-Item -Force -Path rgba8_unorm_bc7.dds -Destination valid_compressed_R8G8B8A8_UNORM_40x40.dds
texconv -nologo -y -m 1 -f R8G8B8A8_UNORM_SRGB -ft dds ${INPUT_DIR}\png\rgba8_srgb_bc7.png -o .; Move-Item -Force -Path rgba8_srgb_bc7.dds -Destination valid_compressed_R8G8B8A8_SRGB_40x40.dds

# DDS BC1-BC7 compressed 2D textures
texconv -nologo -y -m 1 -f BC1_UNORM -ft dds ${INPUT_DIR}\png\rgb8_unorm_bc1.png -o .; Move-Item -Force -Path rgb8_unorm_bc1.dds -Destination valid_compressed_BC1_UNORM_40x40.dds
texconv -nologo -y -m 1 -f BC1_UNORM_SRGB -ft dds ${INPUT_DIR}\png\rgb8_srgb_bc1.png -o .; Move-Item -Force -Path rgb8_srgb_bc1.dds -Destination valid_compressed_BC1_SRGB_40x40.dds
texconv -nologo -y -m 1 -f BC2_UNORM_SRGB -ft dds ${INPUT_DIR}\png\basic_RGBA8_16x16.png -o .; Move-Item -Force -Path basic_RGBA8_16x16.dds -Destination valid_compressed_BC2_SRGB_16x16.dds
texconv -nologo -y -m 1 -f BC3_UNORM -ft dds ${INPUT_DIR}\png\rgba8_unorm_bc3.png -o .; Move-Item -Force -Path rgba8_unorm_bc3.dds -Destination valid_compressed_BC3_UNORM_40x40.dds
texconv -nologo -y -m 1 -f BC3_UNORM_SRGB -ft dds ${INPUT_DIR}\png\rgba8_srgb_bc3.png -o .; Move-Item -Force -Path rgba8_srgb_bc3.dds -Destination valid_compressed_BC3_SRGB_40x40.dds
texconv -nologo -y -m 1 -f BC4_UNORM -ft dds ${INPUT_DIR}\png\r8_unorm_bc4.png -o .; Move-Item -Force -Path r8_unorm_bc4.dds -Destination valid_compressed_BC4_UNORM_40x40.dds
texconv -nologo -y -m 1 -f BC4_SNORM -ft dds ${INPUT_DIR}\png\r8_unorm_bc4.png -o .; Move-Item -Force -Path r8_unorm_bc4.dds -Destination valid_compressed_BC4_SNORM_40x40.dds
texconv -nologo -y -m 1 -f BC5_UNORM -ft dds ${INPUT_DIR}\png\rg8_unorm_bc5.png -o .; Move-Item -Force -Path rg8_unorm_bc5.dds -Destination valid_compressed_BC5_UNORM_40x40.dds
texconv -nologo -y -m 1 -f BC6H_UF16 -ft dds ${INPUT_DIR}\png\basic_RGB16_16x16.png -o .; Move-Item -Force -Path basic_RGB16_16x16.dds -Destination valid_compressed_BC6H_UFLOAT_16x16.dds
texconv -nologo -y -m 1 -f BC6H_SF16 -ft dds ${INPUT_DIR}\png\sbit16_RGB16_16x16.png -o .; Move-Item -Force -Path sbit16_RGB16_16x16.dds -Destination valid_compressed_BC6H_SFLOAT_16x16.dds
texconv -nologo -y -m 1 -f BC7_UNORM -ft dds ${INPUT_DIR}\png\rgba8_unorm_bc7.png -o .; Move-Item -Force -Path rgba8_unorm_bc7.dds -Destination valid_compressed_BC7_UNORM_40x40.dds
texconv -nologo -y -m 1 -f BC7_UNORM_SRGB -ft dds ${INPUT_DIR}\png\rgba8_srgb_bc7.png -o .; Move-Item -Force -Path rgba8_srgb_bc7.dds -Destination valid_compressed_BC7_SRGB_40x40.dds

# DDS volume textures
texassemble volume -nologo -y -f R8G8B8A8_UNORM_SRGB -o valid_compressed_R8G8B8A8_SRGB_slices_6_128x128.dds `
  ${INPUT_DIR}\png\slice0.png ${INPUT_DIR}\png\slice1.png ${INPUT_DIR}\png\slice2.png `
  ${INPUT_DIR}\png\slice3.png ${INPUT_DIR}\png\slice4.png ${INPUT_DIR}\png\slice5.png

# DDS cubemap textures
texassemble cube -nologo -y -f R8G8B8A8_UNORM_SRGB -o valid_compressed_R8G8B8A8_SRGB_faces_6_128x128.dds `
  ${INPUT_DIR}\png\slice0.png ${INPUT_DIR}\png\slice1.png ${INPUT_DIR}\png\slice2.png `
  ${INPUT_DIR}\png\slice3.png ${INPUT_DIR}\png\slice4.png ${INPUT_DIR}\png\slice5.png

# DDS array textures
texassemble array -nologo -y -f R8G8B8A8_UNORM_SRGB -o valid_compressed_R8G8B8A8_SRGB_layers_6_128x128.dds `
  ${INPUT_DIR}\png\slice0.png ${INPUT_DIR}\png\slice1.png ${INPUT_DIR}\png\slice2.png `
  ${INPUT_DIR}\png\slice3.png ${INPUT_DIR}\png\slice4.png ${INPUT_DIR}\png\slice5.png
