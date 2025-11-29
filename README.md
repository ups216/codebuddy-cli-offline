# CodeBuddy Code CLI工具安装和打包指南

> 🎯 **本项目主要目的**：指导用户在私有化离线环境中使用 CodeBuddy Code
> 
> 📖 **快速开始**：查看详细的私有化环境配置指南：[docs/use-cbcli-offline.md](docs/use-cbcli-offline.md)

本指南介绍了如何从 npm 安装 CodeBuddy CLI 以及如何将其打包用于离线/本地安装。

## ✅ 已测试验证

打包过程和生成的 `.tgz` 文件已经过全面测试，可正确用于离线安装。

## 系统要求

- Node.js 18.20 或更高版本
- npm（随 Node.js 提供）
- 初次安装时需要互联网连接

## 从 npm 安装（在线）

### 1. 全局安装 CodeBuddy CLI
```bash
npm install -g @tencent-ai/codebuddy-code
```

### 2. 验证安装
```bash
codebuddy --version
```

### 3. 故障排除
- **找不到命令**：检查 npm 全局 bin 目录是否在 PATH 中
- **网络问题**：配置 npm 镜像：
  ```bash
  npm config set registry https://registry.npmmirror.com
  ```

## 自动化打包（推荐）

### 使用提供的脚本
```bash
./package-codebuddy-cli.sh
```

此脚本将：
- ✅ 检查 Node.js 版本兼容性
- 📦 安装/更新 CodeBuddy CLI
- 🎯 使用 `npm pack` 创建正确的 npm 包
- 📁 将包保存到 `releases/` 目录
- 🔗 为方便起见创建 `latest` 软链接

## 手动打包（替代方案）

### 1. 安装 CodeBuddy CLI
```bash
npm install -g @tencent-ai/codebuddy-code
```

### 2. 创建正确的 npm 包
```bash
cd /tmp
npm pack @tencent-ai/codebuddy-code
mv tencent-ai-codebuddy-code-*.tgz 目标目录/
```

### 3. 重命名以便识别（可选）
```bash
mv tencent-ai-codebuddy-code-2.9.0.tgz codebuddy-cli-2.9.0.tgz
```

## 离线安装

### 1. 从本地包安装
```bash
npm install -g ./codebuddy-cli-2.9.0.tgz
```

### 2. 验证安装
```bash
codebuddy --version
```

## 私有化环境使用

在私有化环境中使用 CodeBuddy CLI 需要完成以下步骤：

### 1. 安装 CodeBuddy CLI
克隆本仓库，或直接下载 releases 目录中的对应版本，然后运行：
```bash
npm install -g ./codebuddy-cli-{version}.tgz
```

### 2. 配置 CodeBuddy CLI
使用 `codebuddy` 指令启动 CLI，选择 "Login with Enterprise Domain"，然后输入企业私有化 CodeBuddy 服务器地址进行登录配置。

### 3. 使用 CodeBuddy CLI
登录成功后，使用 `/model` 指令查看私有化环境中可用的模型列表，选择模型后即可正常使用。

详细配置步骤请参考 [docs/use-cbcli-offline.md](docs/use-cbcli-offline.md)。

## 卸载

```bash
npm uninstall -g @tencent-ai/codebuddy-code
```

## 包信息

- **包名**：`@tencent-ai/codebuddy-code`
- **当前版本**：2.9.0
- **包大小**：约 25.5 MB（标准 npm 包格式）
- **包含内容**：完整的 CLI 及所有依赖项
- **格式**：标准 npm 包（可使用 `npm install -g` 安装）
- **结构**：使用 `package/` 前缀确保 npm 兼容性

## 重要说明

- ✅ **已测试**：使用此方法创建的包已验证可正确安装
- 🏗️ **标准格式**：使用 `npm pack` 创建标准 npm 包
- 📦 **完整**：包含离线安装所需的所有依赖项
- 🌐 **离线可用**：完美适用于隔离环境或无互联网的计算机
- 🔧 **跨平台**：可在运行相同操作系统的计算机间共享
- ⚡ **快速安装**：简单的 `npm install -g ./package.tgz` 命令

## 仓库文件

- `package-codebuddy-cli.sh` - 自动化打包脚本
- `releases/codebuddy-cli-2.9.0.tgz` - 可直接使用的 npm 包
- `releases/codebuddy-cli-latest.tgz` - 指向最新版本的软链接

## 快速参考

| 操作 | 命令 |
|--------|---------|
| **在线安装** | `npm install -g @tencent-ai/codebuddy-code` |
| **自动打包** | `./package-codebuddy-cli.sh` |
| **手动打包** | `npm pack @tencent-ai/codebuddy-code` |
| **离线安装** | `npm install -g ./codebuddy-cli-$(version).tgz` |
| **版本检查** | `codebuddy --version` |
| **卸载** | `npm uninstall -g @tencent-ai/codebuddy-code` |

## 使用示例

```bash
# 使用脚本创建包
./package-codebuddy-cli.sh

# 在其他计算机上从包安装
npm install -g ./releases/codebuddy-cli-2.9.0.tgz

# 或使用最新版本软链接
npm install -g ./releases/codebuddy-cli-latest.tgz
```

---

版权所有 © leansoftx.com 2025