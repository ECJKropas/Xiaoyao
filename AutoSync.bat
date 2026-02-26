@echo off
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