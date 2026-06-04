# 3GShare 项目说明（给 Claude 的指引）

## 项目背景

- 这是我（@dustPyrotechnic）**带的一位学妹**（@lifany-jia）的 iOS 入门**练习 Demo**。
- 目的是让她熟悉 UIKit、Masonry、TableView 复用、轮播图、定时器、RunLoop 等基础知识点。
- **不是生产项目**，不需要追求工程化（无单测、无 CI、无网络层、数据全是写死的本地 Mock）。
- 我以 Code Review / Mentor 的角色介入：发现问题 → 提 Issue 或 PR 让她学习修复。

## 仓库关系

| 角色 | 仓库 |
| :-- | :-- |
| 上游（学妹的原仓库） | `lifany-jia/3G-Share` |
| 我的 Fork（用于提 PR） | `dustPyrotechnic/3G-Share` |
| 本地 remote | `upstream` → 学妹仓库，`origin` → 我的 fork |

## 沟通约定

### 语言
- **所有面向学妹的产出（Issue、PR 标题与正文、commit message、代码注释）一律使用中文。**
- 与我（Sir）的对话也用中文。

### Issue / PR 写作要求

学妹是新手，**Issue 和 PR 的目标不只是"汇报 bug"，更是"教学"**。写的时候必须做到：

1. **问题现象**：用她能复现的步骤描述，不要只写"按钮没反应"这种笼统说法。
2. **根因分析**：明确指出是哪个文件、哪一行、为什么会出问题；涉及到 iOS / Objective-C / RunLoop / 复用机制等知识点时，**简要解释原理**，让她能学到东西而不是只学会改这一行。
3. **修复方案**：给出具体改法（PR 直接是 diff；Issue 给出建议）。
4. **范围声明**：如果是 demo 范围内不需要做的事（例如不需要持久化、不需要防重复点击），**显式说明"demo 范围不必处理"**，避免她过度发挥导致返工。
5. **相关文件清单**：列出涉及的 `.h`/`.m` 文件路径，方便她快速定位。

### Commit / PR 标题格式
- 使用约定式前缀：`fix:` / `feat:` / `refactor:` / `docs:` 等。
- 主体描述用中文，简短一句话说清楚做了什么。

## 代码风格（沿用全局规则）

- Objective-C：2 空格缩进，`///` DocC 注释（`@param` / `@return`）。
- UI 布局统一用 **Masonry**（不用 SnapKit；学妹的项目已经引入了 Pods）。
- 网络层用 AFNetworking、图片用 SDWebImage（目前 demo 还没用上）。

## 工作流

1. 用户（Sir）让我审某段代码 / 某个交互
2. 我定位问题、给出分析
3. Sir 确认后：
   - **代码层修复** → 提 PR 到 `lifany-jia/3G-Share`
   - **设计 / 缺失功能** → 提 Issue 到 `lifany-jia/3G-Share`
4. PR / Issue 必须按上面的"写作要求"撰写，让学妹能从中学习
