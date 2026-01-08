# Claude Skills Collection

这是一个精心设计的 Claude AI 技能集合，用于扩展 Claude 的能力，提供专业化的工作流程、领域知识和工具集成。

## 项目概述

本项目包含多个模块化的技能包，每个技能都专注于特定的领域或任务类型，将 Claude 从通用助手转变为具备专业知识的专门代理。

## 可用技能

### draw-io

draw.io 图表的创建、编辑和审查。用于 .drawio XML 编辑、PNG 转换、布局调整以及 AWS 图标的使用。

### feature-dev

一个全面、结构化的特性开发工作流程，包含代码库探索、架构设计、质量审查和实现等专门阶段。适用于需要深入了解现有代码库、澄清模糊需求、设计周全架构以及通过多维度代码审查确保质量的复杂功能特性。

### file-organizer

通过理解文件内容与使用场景的上下文，智能地在你的电脑中整理文件和文件夹：查找重复文件、建议更合理的目录结构，并自动执行清理任务。适用于归档旧项目、自动清理与重建目录结构。

### frontend-design

创建具有高品质设计、独特且适用于生产环境的 frontend 界面。适用于构建网页组件、页面、工件、海报或应用程序（如网站、着陆页、仪表板、React 组件、HTML/CSS 布局，或对任何网页 UI 进行样式化/美化）。

生成富有创意、精致且避免通用 AI 美学的代码和 UI 设计。

### markdown-writing

创建和修改 markdown 文件的指导原则。适用于编写文档、README 文件或任何 markdown 内容。

### planning-with-files

将工作流程转换为使用 Manus 风格的持久性 Markdown 文件，用于规划、进度跟踪和知识存储。适用于启动复杂任务、多步骤项目、研究任务，或当用户提及规划、组织工作、跟踪进度或需要结构化输出时。

### skill-creator

高效 skill 创建指南。当用户希望创建新的 skill（或更新现有 skill），以通过专业知识、特定工作流或工具集成来扩展 Claude 的能力时使用。

### spec-interview

深度访谈以完善技术规格或用户指定的文档说明书。当存在 plan.md 或者用户指定文档需要通过系统性提问来完善需求时使用，涵盖技术实现、UI/UX 设计、边缘情况、风险考量、权衡取舍和架构决策。

### web-artifacts-builder

一套用于构建复杂且多组件集成的 claude.ai HTML Artifacts（交互式组件）的工具集。该工具集采用现代前端技术栈，包括 React、Tailwind CSS 及 shadcn/ui。

适用于需要状态管理、路由功能或集成 shadcn/ui 组件库的复杂项目，而非简单的单文件 HTML/JSX 组件。

### youtube-downloader

下载 YouTube 视频，支持自定义画质与格式选项。支持多种画质设置（最佳、1080p、720p、480p、360p）、多种格式（mp4、webm、mkv）以及仅音频下载为 MP3。

## 项目结构

```markdown
my_claude_skills/
├── draw-io/
│   ├── SKILL.md
│   ├── references/
│   └── scripts/
├── feature-dev/
│   ├── SKILL.md
│   └── references/
├── file-organizer/
│   └── SKILL.md
├── frontend-design/
│   ├── LICENSE.txt
│   └── SKILL.md
├── markdown-writing/
│   └── SKILL.md
├── planning-with-files/
│   ├── examples.md
│   ├── reference.md
│   └── SKILL.md
├── skill-creator/
│   ├── LICENSE.txt
│   ├── SKILL.md
│   ├── references/
│   └── scripts/
├── spec-interview/
│   └── SKILL.md
├── web-artifacts-builder/
│   ├── LICENSE.txt
│   ├── SKILL.md
│   └── scripts/
└── youtube-downloader/
    ├── SKILL.md
    └── scripts/
```

## 核心原则

### 简洁至上

上下文窗口是公共资源。技能与系统提示、对话历史、其他技能的元数据以及实际用户请求共享上下文窗口。默认假设：Claude 已经非常智能。只添加 Claude 尚不具备的上下文。

### 适当的自由度

根据任务的脆弱性和可变性匹配特定的自由度级别：

- **高自由度（基于文本的指令）**：当多种方法都有效时使用，决策取决于上下文，或使用启发式方法指导方法
- **中等自由度（带参数的伪代码或脚本）**：当存在首选模式、某些变化可接受时使用，或配置影响行为
- **低自由度（特定脚本、少量参数）**：当操作脆弱且容易出错、一致性至关重要时使用，或必须遵循特定序列

### 渐进式披露设计

技能使用三级加载系统来高效管理上下文：

1. **元数据（名称 + 描述）** - 始终在上下文中（约 100 个词）
2. **SKILL.md 主体** - 当技能触发时（<5k 词）
3. **捆绑资源** - 根据需要由 Claude 加载（无限，因为脚本可以在不读取到上下文窗口的情况下执行）

## 技能创建流程

1. **理解技能**：通过具体示例理解技能
2. **规划可重用内容**：规划可重用的技能内容（脚本、引用、资产）
3. **初始化技能**：运行 init_skill.py
4. **编辑技能**：实现资源并编写 SKILL.md
5. **打包技能**：运行 package_skill.py
6. **迭代改进**：基于实际使用进行迭代

## 许可证

部分技能包含特定的许可证文件，请参考各个技能目录中的 LICENSE.txt 文件。

## 贡献

欢迎贡献新的技能或改进现有技能。请遵循 skill-creator 中定义的指导原则和最佳实践。

## 联系方式

项目仓库：ssh://git@ssh.github.com:443/huminglong/my_claude_skills.git