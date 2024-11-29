<img height="120" src="./assets/AutoHotkey2 64x64.png">

# 在 Windows 上使用 Mac 风格快捷键
<!-- # MacStyleKeys-By-Win -->

**简体中文** · [English](./README.md)

<!-- **English** · [简体中文](./README.zh-CN.md) -->

## 简介
`MacStyleKeys` 是一个工具，旨在让 Windows 用户能够体验到类似于 macOS 的快捷键操作。通过这个工具，用户可以轻松地在 Windows 系统中使用 Mac 风格的快捷键，提高工作效率。

## 环境要求
- 本项目基于 AutoHotkey 2.0.18
- Windows 操作系统

## 功能特点
- **自定义按键绑定**: 可自定义按键映射以匹配 macOS 快捷键
- **无缝集成**: 与大多数 Windows 应用程序完美兼容
- **用户友好界面**: 简单易用的配置方式

## 按键映射

### 基础操作
#### 光标移动
- **字符级移动**:
  - `Ctrl + b`: 左移一个字符
  - `Ctrl + f`: 右移一个字符
  - `Ctrl + p`: 上移一行
  - `Ctrl + n`: 下移一行
  - `Ctrl + q`: 移动到行首
  - `Ctrl + e`: 移动到行尾

- **单词级移动**:
  - `Win + b`: 左移一个单词
  - `Win + f`: 右移一个单词

#### 删除操作
- **字符级删除**:
  - `Ctrl + h`: 删除光标左侧字符
  - `Ctrl + d`: 删除光标下的字符

- **整行删除**:
  - `Ctrl + u`: 删除从光标到行首
  - `Ctrl + k`: 删除从光标到行尾（非终端中有效）

### 标签页管理
- `Win + q`: 切换到上一个标签页 (Shift + Tab)
- `Win + w`: 关闭当前标签页
- `Win + e`: 切换到下一个标签页 (Tab)

### 剪贴板操作
- `Win + c`: 复制 (Ctrl + Shift + C)
- `Win + v`: 粘贴 (Ctrl + Shift + V)

### Alt 快捷键组合
#### 文件操作
- `Alt + s`: 保存
- `Alt + o`: 打开
- `Alt + w`: 关闭
- `Alt + n`: 新建
- `Alt + t`: 新建标签页

#### 编辑操作
- `Alt + z`: 撤销
- `Alt + x`: 剪切
- `Alt + c`: 复制
- `Alt + v`: 粘贴
- `Alt + a`: 全选
- `Alt + f`: 查找
- `Alt + g`: 查找下一个
- `Alt + /`: 注释

### 终端特定快捷键
- `Alt + c`: 复制 (Ctrl + Insert)
- `Alt + v`: 粘贴 (Shift + Insert)
- `Alt + r`: 搜索命令历史

### 高级组合键
#### Ctrl + Win 组合
- `Ctrl + Win + b`: 左移一个单词
- `Ctrl + Win + f`: 右移一个单词
- `Ctrl + Win + h`: 删除左侧单词
- `Ctrl + Win + d`: 删除右侧单词

#### Ctrl + Alt 组合
- `Ctrl + Alt + b`: 左移一个单词
- `Ctrl + Alt + f`: 右移一个单词
- `Ctrl + Alt + h`: 删除左侧单词


## 安装说明
1. 从[发布页面](https://github.com/frankervo/MacStyleKeys-By-Win/releases)下载最新版本
2. 双击运行
3. 任务栏出现 AutoHotKeys 图标运行成功
