@echo off

rem This file is UTF-8 encoded, so we need to update the current code page while executing it
for /f "tokens=2 delims=:." %%a in ('"%SystemRoot%\System32\chcp.com"') do (
    set _OLD_CODEPAGE=%%a
)
if defined _OLD_CODEPAGE (
    "%SystemRoot%\System32\chcp.com" 65001 > nul
)

set "VIRTUAL_ENV=E:\逍遥游\main\xiaoyao_prgs"

if not defined PROMPT set PROMPT=$P$G

if defined _OLD_VIRTUAL_PROMPT set PROMPT=%_OLD_VIRTUAL_PROMPT%
if defined _OLD_VIRTUAL_PYTHONHOME set PYTHONHOME=%_OLD_VIRTUAL_PYTHONHOME%

set "_OLD_VIRTUAL_PROMPT=%PROMPT%"
set "PROMPT=(xiaoyao_prgs) %PROMPT%"

if defined PYTHONHOME set _OLD_VIRTUAL_PYTHONHOME=%PYTHONHOME%
set PYTHONHOME=

if defined _OLD_VIRTUAL_PATH set PATH=%_OLD_VIRTUAL_PATH%
if not defined _OLD_VIRTUAL_PATH set _OLD_VIRTUAL_PATH=%PATH%

set "PATH=%VIRTUAL_ENV%\Scripts;%PATH%"
set "VIRTUAL_ENV_PROMPT=xiaoyao_prgs"


setlocal enabledelayedexpansion



echo 正在同步 Git 仓库...

REM 检查 msg.txt 是否存在
if not exist msg.txt (
    echo 错误：当前目录下未找到 msg.txt 文件。
    exit /b 1
)

REM 执行 git add
git add .
if errorlevel 1 (
    echo 错误：git add 失败。
    exit /b 1
)

REM 检查是否有文件需要提交
git diff --cached --quiet
if errorlevel 1 (
    echo 检测到有暂存的更改，正在提交...
    git commit -F msg.txt
    if errorlevel 1 (
        echo 错误：git commit 失败。
        exit /b 1
    )
) else (
    echo 没有需要提交的更改，跳过提交步骤。
)

REM 执行 git pull
git pull
if errorlevel 1 (
    echo 错误：git pull 失败。请手动解决冲突后再运行推送。
    exit /b 1
)

REM 执行 git push
git push
if errorlevel 1 (
    echo 错误：git push 失败。
    exit /b 1
)

echo 同步完成。