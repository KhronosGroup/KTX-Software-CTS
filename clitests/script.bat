@echo off
set PYTHON=python
set SCRIPT=clitest.py
set ROOT="./tests/transcode"

for /r "%ROOT%" %%f in (*.json) do (
    echo Processing %%f
    %PYTHON% "%SCRIPT%" -e ktx.exe -d ktxdiff.exe "%%f"
)