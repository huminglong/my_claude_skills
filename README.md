<div align="center">

# 🧠 Claude Skills Collection

**模块化的 Claude AI 技能扩展包，让 Claude 成为你的专业领域专家**

[![Skills](https://img.shields.io/badge/Skills-11-blue?style=flat-square)](.)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](.)

[概述](#概述) • [可用技能](#可用技能) • [快速开始](#快速开始) • [项目结构](#项目结构) • [核心原则](#核心原则)

</div>

---

## 概述

Skills 是模块化、自包含的扩展包，通过提供专业知识、工作流程和工具，扩展 Claude 的能力。可以将其理解为特定领域的「培训手册」——它们将 Claude 从通用助手转变为具备专业程序性知识的领域专家。

每个 Skill 提供：

- **专业工作流** — 特定领域的多步骤操作流程
- **工具集成** — 特定文件格式或 API 的使用指南
- **领域知识** — 业务逻辑、架构规范、最佳实践
- **资源捆绑** — 脚本、模板、参考文档等

## 可用技能

| 技能                      | 说明                                      | 资源        |
| ------------------------- | ----------------------------------------- | ----------- |
| **bash-script-expert**    | 编写模块化、生产级 Bash 脚本的专家指导    | 模板        |
| **draw-io**               | draw.io 图表创建与编辑，支持 AWS 图标     | 脚本 / 参考 |
| **feature-dev**           | 全流程功能开发工作流：探索→设计→审查→实现 | 参考        |
| **file-organizer**        | 智能文件整理：去重、结构优化、自动清理    | —           |
| **frontend-design**       | 高品质前端 UI 设计与代码生成              | —           |
| **markdown-writing**      | Markdown 文档编写最佳实践                 | —           |
| **planning-with-files**   | Manus 风格持久化规划与进度追踪            | 示例 / 参考 |
| **skill-creator**         | 创建和维护 Claude Skills 的元技能         | 脚本 / 参考 |
| **spec-interview**        | 系统性访谈以完善技术规格文档              | —           |
| **web-artifacts-builder** | 构建复杂的 claude.ai HTML Artifacts       | 脚本        |
| **youtube-downloader**    | YouTube 视频下载，支持多画质与格式        | 脚本        |

## 快速开始

### 安装

将技能复制到 Claude 的 skills 目录：

```bash
# 复制单个技能
cp -r skill-creator ~/.claude/skills/

# 或复制全部技能
cp -r ./* ~/.claude/skills/
```

### 使用

安装后，Claude 会根据对话内容自动识别并激活相关技能。你也可以明确请求：

```
请使用 planning-with-files 技能帮我规划这个项目
```

> [!TIP]
> 每个技能的 `SKILL.md` 文件包含完整的使用说明和示例。

## 项目结构

```
claude-skills/
├── skill-name/
│   ├── SKILL.md          # 核心指令文件（必需）
│   ├── scripts/          # 可执行脚本
│   ├── references/       # 参考文档
│   └── assets/           # 模板、图标等资源
└── ...
```

每个技能遵循统一的目录结构：

| 目录/文件     | 用途                                        |
| ------------- | ------------------------------------------- |
| `SKILL.md`    | **必需** — 包含 YAML 元数据和 Markdown 指令 |
| `scripts/`    | Python/Bash 脚本，用于确定性任务            |
| `references/` | 按需加载的参考文档                          |
| `assets/`     | 模板、字体、图标等输出资源                  |

## 核心原则

### 简洁至上

上下文窗口是公共资源。技能与系统提示、对话历史和用户请求共享上下文。

> **默认假设：Claude 已经非常智能。** 只添加 Claude 尚不具备的上下文。

### 适当的自由度

根据任务的脆弱性和可变性匹配指令的具体程度：

| 自由度 | 适用场景                     | 形式                |
| ------ | ---------------------------- | ------------------- |
| **高** | 多种方法有效，决策依赖上下文 | 文本指令            |
| **中** | 存在首选模式，允许部分变化   | 带参数的伪代码/脚本 |
| **低** | 操作脆弱，一致性关键         | 特定脚本，少量参数  |

### 渐进式披露

技能使用三级加载系统高效管理上下文：

1. **元数据** — 始终在上下文中（名称 + 描述，~100 词）
2. **SKILL.md** — 技能触发时加载（<5k 词）
3. **捆绑资源** — 按需加载（脚本可直接执行，无需读入上下文）

## 创建新技能

使用 `skill-creator` 技能来创建新的技能：

```bash
# 初始化技能目录结构
python skill-creator/scripts/init_skill.py new-skill-name

# 验证技能结构
python skill-creator/scripts/quick_validate.py new-skill-name/

# 打包技能
python skill-creator/scripts/package_skill.py new-skill-name/
```

> [!NOTE]
> 详细的技能创建指南请参考 [skill-creator/SKILL.md](skill-creator/SKILL.md)。

## 资源

- [Claude Desktop Skills 文档](https://docs.anthropic.com/en/docs/claude-code/skills)
- [skill-creator 技能创建指南](skill-creator/SKILL.md)
- [planning-with-files 示例](planning-with-files/examples.md)
