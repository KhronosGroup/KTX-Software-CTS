<!-- Copyright 2022-2023 The Khronos Group Inc. -->
<!-- Copyright 2022-2023 RasterGrid Kft. -->
<!-- SPDX-License-Identifier: Apache-2.0 -->


# KTX-Software-CTS

Conformance Test Suite for [KhronosGroup/KTX-Software](https://github.com/KhronosGroup/KTX-Software)
containing black box test cases for the KTX CLI tools. CTS is included as a git submodule in the [KTX-Software](https://github.com/KhronosGroup/KTX-Software) repository.

Unit tests and other white box tests can be found in the main
[KhronosGroup/KTX-Software](https://github.com/KhronosGroup/KTX-Software) repository.
For building and running the tests see the [KTX documentation about building CTS](https://github.com/KhronosGroup/KTX-Software/blob/main/BUILDING.md).

### Structure

CTS is driven with a python [runner script](clitests/clitest.py) with data coming from the following directories:
- [clitests/tests](clitests/tests): JSON test case files.
- [clitests/input](clitests/input): Input files for testing with both valid and invalid files.
- [clitests/output](clitests/output): Working directory for storing the generated outputs during testing.
- [clitests/golden](clitests/golden): Expected output reference ("golden") files for the test cases.


### Test cases

CTS splits tests into multiple test files which are organized in a directory structure by command and test case names.
Each file is a separate test case with potentially multiple subcases which are automatically generated from permutations of the specified arguments.
Each test case file must be added to the CASELIST variable defined in the [CMakeLists.txt](clitests/CMakeLists.txt) file where it will be registered to ctest.
The test cases can be run with the python [runner script](clitests/clitest.py) or with ctest.
By default, matching output files will be deleted unless the `--keep-matching-outputs` flag is passed to the runner script.

Each JSON test case file shall contain a root object with the following properties:
- `description (string)`: Human readable description of the given test case.
- `command (eval-string)`: Command that will be executed. For `ktx` tests use the --testrun flag to run the CLI tools in a mode where they produce deterministic output whenever possible.
- `status (int | eval-string)`: Expected status code returned by the command. If the status code does not match the value the test fails.
- `comment (string)`: Unevaluated and unused. Useful to leave comments in the test case file.
- `stdout (eval-string)`: Filepath for golden stdout file. If there is a mismatch between the golden file and the stdout the test fails. Optional: If the property is missing then the stdout of the command is not checked.
- `stdoutBinary (bool | eval-string)`: Marks whether the stdout should be interpreted as binary data. Binary stdout golden files are not checked for regex matching. Used for testing file outputs onto stdout. Optional: If the property is missing then the stdout will be treated as text.
- `stderr (eval-string)`: Filepath for golden stderr file. If there is a mismatch between the golden file and the stderr the test fails. Optional: If the property is missing then the stderr of the command is not checked.
- `stdin (eval-string)`: Filepath for a file that will be redirected to stdin. Optional: If the property is missing then the stdin of the command is not supplied.
- `outputTolerance (false | float | eval-string)`: Allow mismatch of golden and output files on non-primary platforms (platforms that are not marked with `--primary` for the `clitest.py`) with the given tolerance. On non-primary platforms, it also disables golden file generation. When set to false, the test case expects an exact match of the output files while float values allow numerical differences in the image data on non-primary platforms. For example BasisLZ compression relies on the undefined order of std::unordered_map containers
so for certain test cases the outputs are not deterministic. Optional: defaults to false.
- `outputs (dictionary)`: Key-Value dictionary of every expected output file and corresponding golden file. If there is a mismatch between any of the golden and output files the test fails. Optional: If the property is missing the output files of the command are not checks.
    - `<key> (eval-string)`: Filepath for a generated output file.
    - `<value> (eval-string)`: Filepath for a golden file that should match the generated output file.
- `args (dictionary)`: Permutation context dictionary for eval-string evaluations. Optional, If missing the context will be empty.
    - `<key> (string)`: Identifier for the argument that can be referenced from the evalulation contexts.
    - `<value> (list<string | object>)`: List of string values or JSON objects for the argument. Objects can be used to group multiple argument values when generating test case permutation. Individual arguments can be referenced from the evaluation contexts.

Where `eval-string` is a string that can use python eval expressions like `${subcase}` or `${format[flag]}`. The evaluation context is provided by the `args` dictionary. The test case will execute a subcase with an evaluation context corresponding to each permutation of values specified for the keys in the `args` dictionary.

Example:
```json
{
    "description": "Test case description.",
    "command": "ktx my_command ${format[flag]} input/${subcase}.ktx2 output/my_command/${subcase}.${format[ext]}",
    "status": 0,
    "outputs": {
        "output/my_command/${subcase}.${format[ext]}": "golden/my_command/${subcase}.${format[ext]}"
    },
    "args": {
        "format": [
            { "ext": "json", "flag": "--format json" },
            { "ext": "txt", "flag": "--format txt" }
        ],
        "subcase": [
            "file_0",
            "file_1"
        ]
    }
}
```
This example will result in the testing of the following 4 (2 * 2 permutations) command executions:
```
ktx my_command --format json input/file_0.ktx2 output/my_command/file_0.json
ktx my_command --format json input/file_1.ktx2 output/my_command/file_1.json
ktx my_command --format txt input/file_0.ktx2 output/my_command/file_0.txt
ktx my_command --format txt input/file_1.ktx2 output/my_command/file_1.txt
```

Where the following 4 corresponding output pairs will be checked:
```
output/my_command/file_0.json == golden/my_command/file_0.json
output/my_command/file_1.json == golden/my_command/file_1.json
output/my_command/file_0.txt  == golden/my_command/file_0.txt
output/my_command/file_1.txt  == golden/my_command/file_1.txt
```


### Using the Test Runner

The `clitest.py` test runner script has the following arguments:
- `-r | --regen-golden`: Optional flag that enables regenerating golden reference files, as described later.
- `-e | --executable-path <path>`: Required argument that specifies the location of the KTX CLI tool executable
- `-d | --ktxdiff-path <path>`: Optional argument that specifies the location of the KTX test diff tool which enables comparing outputs of test cases using the `outputTolerance` parameter. If this argument is not specified, then test cases requiring output comparison with tolerance cannot be executed.
- `--primary`: Optional argument indicating that the test case is ran on a primary platform (as described later). If this argument is not specified, then the golden outputs of test cases using the `outputTolerance` parameter cannot be regenerated.
- `--keep-matching-outputs`: Optional argument indicating that the output files produced by the test case under the [clitests/output](clitests/output) directory should be kept even if they match the golden references.


### Workflow

To work with the CTS, first set up an environment for [KTX-Software with CTS](https://github.com/KhronosGroup/KTX-Software/blob/main/BUILDING.md#Conformance-Test-Suite).

The general CTS workflow should be:
1. Create or update one or more test case JSON files.
2. Add any new test case files to the CASELIST of the [CMakeLists.txt](clitests/CMakeLists.txt).
3. Create the necessary input files for the test case.
4. Create the necessary golden files for the test case.
5. Run `ctest` (Example: `ctest --test-dir build`).


#### Golden Regex in Text Output References

Golden text output references (reference `stdout` and `stderr` files) support regular expressions which can be specified between `` markers.
Portions of the text output between `` marks will be matched as regular expressions against the actual outputs. This can be useful for system specific error messages,  multi-use golden files, or for accepting some non-deterministic value.
For example the following stderr file could be used as golden file for every platform and system language:
```
Could not open input file "input/file/path": `.+`
```


#### Regenerating Golden Files

When creating the golden files a common use-case is to just accept the currently generated output as a golden sample if the outputs were manually verified to be correct. There is built-in support for this in the tooling.

The golden outputs of individual test cases can be regenerated by specifying the `--regen-golden` argument to  the test runner script. 
Example:
```bash
# Inside the clitests directory (.../KTX-Software/tests/cts/clitests):
./clitest.py --executable-path ../../../build/tools/ktx/ktx.exe --ktxdiff-path ../../../build/tests/ktxdiff/ktxdiff --regen-golden tests/info/help.json
# Note that the --executable-path and --ktxdiff-path is dependent on your local configuration
```

In addition, the `clitests_regen_golden` CMake target enables regenerating (creating or overriding) golden files for every test. After regeneration, a tool like `git diff` can be used to verify the changes. Regeneration also makes it easier to change any wording or formatting as golden files can be updated in an automated* manner.

*Golden files containing regular expressions are not updated as part of golden file regeneration, and thus need to be manually updated.

Example usage of for `clitests_regen_golden`:
```bash
# Create or override every golden file from the current outputs of the program
cmake --build build --target clitests_regen_golden
```
**Warning**: As `clitests_regen_golden` will override every* golden file, a careless commit could introduce unintended changes. After regenerating the golden files, it is always necessary to carefully review the changes with `git diff` before committing them.

Another thing to consider when regenerating golden files is that test cases using the `outputTolerance` parameter to allow some tolerance in the output image data with respect to the golden references. In order to prevent "drifting" of image data in golden reference files that may be caused by generating the golden files on a compiler stack that produces code with different precision or determinism compared to the other supported platforms, the CTS suite treats GCC as the "primary" platform for the purposes of regenerating the golden files for test cases with output tolerance enabled. As such, the `clitests_regen_golden` target will not regenerate the golden files of test cases with output tolerance enabled except when it is configured with the GCC compiler stack. For similar reasons, when regenerating the golden outputs of individual test cases, the `--primary` flag has to be specified explicitly when issuing the `clitest.py` script.

**Warning**: Do not use the `--primary` argument when using a different compiler stack to avoid regenerating golden files on a non-primary platform.


### License

See [LICENSE](LICENSE.md) for information about licensing.
