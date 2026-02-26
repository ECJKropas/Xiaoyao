@echo off
setlocal enabledelayedexpansion

REM 同步 Git 仓库脚本
REM 提交信息从当前目录的 msg.txt 读取
REM 如果 msg.txt 不存在，脚本退出并报错

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

REM 执行 git commit，使用 -F 从文件读取提交信息
git commit -F msg.txt
if errorlevel 1 (
    echo 错误：git commit 失败。可能没有需要提交的更改。
    exit /b 1
)

REM 执行 git pull，拉取远程更新并合并
git pull
if errorlevel 1 (
    echo 错误：git pull 失败。请手动解决冲突后再运行推送。
    exit /b 1
)

REM 执行 git push，推送本地提交到远程仓库
git push
if errorlevel 1 (
    echo 错误：git push 失败。
    exit /b 1
)

echo 同步完成。