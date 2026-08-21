# Mars Admin

<p align="center">
  <a href="https://github.com/muhanking111/mars"><img alt="GitHub stars" src="https://img.shields.io/github/stars/muhanking111/mars?style=for-the-badge&logo=github"></a>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/license-Apache%202.0-111827?style=for-the-badge"></a>
  <a href="mars-server/pom.xml"><img alt="Spring Boot" src="https://img.shields.io/badge/Spring%20Boot-3.0.5-6db33f?style=for-the-badge&logo=springboot&logoColor=white"></a>
  <a href="mars-web/package.json"><img alt="Vue" src="https://img.shields.io/badge/Vue-3-42b883?style=for-the-badge&logo=vuedotjs&logoColor=white"></a>
  <a href="mars-web/package.json"><img alt="Ant Design Vue" src="https://img.shields.io/badge/Ant%20Design%20Vue-4.2.6-1677ff?style=for-the-badge"></a>
</p>

Mars 是一个前后端分离的企业管理系统示例，提供 Web 管理端、Spring Boot 后端和移动端工程。仓库集中演示 RBAC 权限、Redis 会话、文件存储、SQL/系统监控、WebSocket 聊天和 Snail-Job 任务调度等常见后台能力。

> **项目状态**：适合学习、二次开发和本地部署。公开仓库中的默认账号与示例配置只用于演示，生产环境必须替换密钥、密码和外部服务配置。

## 目录

- [功能概览](#功能概览)
- [技术栈](#技术栈)
- [仓库结构](#仓库结构)
- [快速开始](#快速开始)
- [文档与在线预览](#文档与在线预览)
- [安全说明](#安全说明)
- [许可证](#许可证)

## 功能概览

- **身份与权限**：Sa-Token、RBAC、动态菜单、角色/部门/岗位管理。
- **系统管理**：参数、字典、登录日志、操作审计和接口文档。
- **运行监控**：CPU、内存、磁盘、JVM、Redis、在线用户和 SQL 日志。
- **文件服务**：本地、MinIO 和阿里云 OSS 策略，可按配置切换。
- **实时协作**：WebSocket 聊天和会话管理。
- **任务调度**：Snail-Job 服务端与客户端集成。
- **多端交付**：Vue 3 Web 管理端，以及 UniApp 小程序/H5/App 工程。

## 技术栈

| 层 | 技术 |
| --- | --- |
| 后端 | Java 17、Spring Boot 3.0.5、MyBatis-Flex、Sa-Token |
| 数据与基础设施 | MySQL 8、Redis 7、Druid、MinIO/OSS |
| Web 管理端 | Vue 3、TypeScript、Vite 6、Ant Design Vue 4、Pinia、ECharts |
| 移动端 | UniApp、Vue、微信小程序/H5/App |
| 工程化 | Maven、pnpm、Knife4j、Snail-Job |

## 仓库结构

```text
mars/
├── mars-server/   # Spring Boot 后端 API、权限、监控、文件和聊天能力
├── mars-web/      # Vue 3 + Ant Design Vue 管理端
├── sql/            # 数据库脚本和初始化资源
└── LICENSE
```

## 快速开始

### 环境要求

- Java 17+
- Maven 3.6+
- Node.js 18.12+
- pnpm 8.7+
- MySQL 8+
- Redis 7+

### 1. 初始化数据库

在 MySQL 中创建数据库并导入仓库提供的脚本。脚本位置以当前仓库为准：

```sql
CREATE DATABASE mars_admin CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

```powershell
mysql -u root -p mars_admin < mars-server/doc/chaoyou.sql
```

### 2. 配置后端

复制 `mars-server/.env.example`，再按本机环境设置 MySQL、Redis、文件存储和会话配置。不要提交真实密码、Token 或云服务密钥。

### 3. 启动后端

```powershell
cd mars-server
mvn spring-boot:run
```

默认 API 文档入口：`http://localhost:8080/doc.html`。实际端口以 `mars-server/src/main/resources` 下的配置为准。

### 4. 启动 Web 管理端

```powershell
cd mars-web
pnpm install
pnpm dev
```

### 5. 启动移动端

使用 HBuilderX 打开移动端工程，按目标平台运行到微信开发者工具、H5 或 App。移动端请求地址需要指向已启动的后端服务。

## 文档与在线预览

- 在线 Web 预览：<https://web.marsadmin.cn/>
- API 文档：<https://web.marsadmin.cn/doc.html>
- 后端说明：[`mars-server/README.md`](./mars-server/README.md)
- 数据库脚本：[`mars-server/doc/chaoyou.sql`](./mars-server/doc/chaoyou.sql)

在线预览和体验账号属于公开环境信息，使用前请以站点当前状态为准。不要把演示账号用于生产环境。

## 安全说明

- 生产环境替换所有默认密码、JWT/Token 密钥和数据库凭证。
- 关闭不需要的 Swagger、SQL 日志、调试接口和管理入口。
- 为文件上传配置类型、大小、路径和访问权限限制。
- 通过 HTTPS、反向代理和网络访问控制保护管理端与 API。
- 提交前检查 `.env`、私钥、证书和日志中是否包含敏感信息。

## 许可证

本项目使用 [Apache License 2.0](./LICENSE)。第三方依赖和外部服务遵循各自许可证与服务条款。
