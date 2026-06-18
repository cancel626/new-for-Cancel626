# 宠物领养系统（Pet Adopt System）

一个基于 Spring Boot + Vue 2 的宠物领养与送养管理平台，包含用户端、管理端，支持宠物发布、领养申请、评论互动、公告通知、地址管理等功能。

---

## 技术栈

### 后端（Backend）

- **核心框架**：Spring Boot 2.2.4
- **持久层**：MyBatis / MyBatis-Plus
- **数据库**：MySQL 8
- **缓存**：Redis
- **安全认证**：JWT
- **文件存储**：阿里云 OSS
- **邮件服务**：Spring Mail（QQ 邮箱 SMTP）
- **其他**：Lombok、AOP、EasyExcel、Jsoup

### 前端（Frontend）

- **框架**：Vue 2.6
- **路由**：Vue Router 3
- **UI 组件库**：Element UI 2.15
- **富文本编辑器**：wangEditor / Toast UI Editor
- **图表**：ECharts 4
- **构建工具**：Vue CLI 4.5

---

## 项目结构

```
pet_need/
├── scaffold/
│   ├── api/          # 后端服务（Spring Boot）
│   ├── view/         # 前端页面（Vue 2）
│   └── sql/          # 数据库初始化脚本
└── README.md
```

---

## 主要功能模块

| 模块 | 说明 |
|------|------|
| 用户管理 | 注册、登录、JWT 认证、密码修改、个人信息维护 |
| 宠物管理 | 宠物发布、编辑、审核、推荐、领养状态管理 |
| 宠物类型 | 宠物分类维护 |
| 领养订单 | 领养申请、订单状态流转 |
| 交流互动 | 宠物帖子发布、评论、点赞 |
| 公告通知 | 系统公告发布与展示 |
| 地址管理 | 用户收货/联系地址维护 |
| 反馈建议 | 用户意见反馈 |
| 数据统计 | 后台数据图表展示 |
| 文件上传 | 图片上传至阿里云 OSS |

---

## 快速开始

### 1. 环境准备

- JDK 1.8+
- Maven 3.6+
- MySQL 8
- Redis 5+
- Node.js 14+（前端）

### 2. 数据库初始化

1. 创建数据库 `pet_adopt_system`。
2. 执行 `scaffold/sql/anonymous/pet_adopt_system/` 目录下的所有 SQL 脚本。

### 3. 后端启动

1. 进入 `scaffold/api/`。
2. 根据实际环境修改 `src/main/resources/application.yml` 中的数据库、Redis、OSS、邮箱等配置。
3. 运行 `PetAdoptApplication.java` 启动类，或使用 Maven 命令：

```bash
mvn spring-boot:run
```

后端默认地址：`http://localhost:21090/api/v1.0/pet-adopt-api`

### 4. 前端启动

1. 进入 `scaffold/view/`。
2. 安装依赖：

```bash
npm install
```

3. 启动开发服务器：

```bash
npm run dev
```

前端默认地址：`http://localhost:8080`

---

## 注意事项

- 首次运行前，请务必将 `application.yml` 中的数据库密码、Redis 密码、阿里云 OSS 密钥、邮箱授权码等敏感信息替换为自己的配置。
- 生产环境部署时，建议使用环境变量或配置中心管理敏感配置，避免直接提交到代码仓库。

---

## 贡献

欢迎提交 Issue 或 Pull Request。
