# 3GShare AI 阅读文稿

本文档给后续 AI 或协作者快速接手项目使用。阅读方式采用渐进式披露：先建立全局心智模型，再按任务下钻到模块级 `memory.md`。

## L0：30 秒总览

- 这是一个 Objective-C + UIKit 的 iOS 练习 Demo，UI 基本为纯代码创建，布局主要使用 Masonry。
- 项目没有真实网络层、数据库、持久化账户或真实上传流程；数据集中写在本地 Model 或 ViewController 里。
- 运行入口是 `SceneDelegate`，首屏是 `LoginVC`。默认账号是 `admin`，密码是 `123456`。
- 登录成功后切换到 5 个 Tab：首页、搜索、文章、活动、个人信息。
- 文章点赞状态依赖 `TypeArtiModel` 的单例对象共享，并通过 `ArticleLikedDidChange` 通知刷新多个页面。
- 工程使用 Xcode 文件系统同步组。新增 Markdown 文档必须排除 target membership，不能进入编译或资源构建。

## L1：启动和主导航

启动路径：

```text
main.m
  -> AppDelegate
  -> SceneDelegate scene:willConnectToSession:
  -> LoginVC wrapped in UINavigationController
  -> LoginVC switchToTabBar
  -> UITabBarController with 5 UINavigationController children
```

主 Tab：

| Tab | 根控制器 | 模块文档 |
| --- | --- | --- |
| 首页 | `HomeVC` | `3GShare/Home/memory.md` |
| 搜索 | `SearchVC` | `3GShare/Search/memory.md` |
| 文章 | `ArticleVC` | `3GShare/Article/memory.md` |
| 活动 | `TaskVC` | `3GShare/Task/memory.md` |
| 个人信息 | `PersonVC` | `3GShare/Person/memory.md` |

辅助模块：

| 模块 | 说明 | 模块文档 |
| --- | --- | --- |
| 登录注册 | 登录、注册、账号 Mock、输入框组件 | `3GShare/Login/memory.md` |
| 我的喜欢 | 个人中心里的喜欢列表 | `3GShare/Person/Like/memory.md` |
| 消息 | 消息入口、关注、私信、聊天 | `3GShare/Person/Message/memory.md` |
| 设置 | 基本资料、密码、消息设置 | `3GShare/Person/Set/memory.md` |
| App 外壳 | 入口、依赖、跨模块约定 | `3GShare/memory.md` |

## L2：工程和依赖

- Workspace：优先打开 `3GShare.xcworkspace`，因为项目使用 CocoaPods。
- Target：主 target 是 `3GShare`。
- Podfile：`Masonry` 是主要布局库，`LookinServer` 只在 Debug 配置启用。
- Xcode 工程对象版本为 77，主源码目录 `3GShare/` 是 `PBXFileSystemSynchronizedRootGroup`。
- `project.pbxproj` 里存在 `PBXFileSystemSynchronizedBuildFileExceptionSet`，当前用于排除 `Info.plist` 和本文档体系中的 `memory.md`。
- 不要把 AI 文档加入 Sources、Resources 或 Copy Bundle Resources。新增源码目录下的文档后，需要继续维护同步组的 `membershipExceptions`。

## L3：共享数据和跨模块行为

### 用户数据

`UserInfo` 负责两个不同概念：

- 静态账号字典：`+account` 中默认 `admin/123456`，注册只写入内存。
- 默认用户资料：`+defaultUserInfo` 通过 `dispatch_once` 返回单例，供个人中心和详情页展示头像、昵称、签名、菜单项。

没有本地持久化。退出 App 或重新启动后，新注册账号不会保留。

### 文章数据

`ArticleModel` 是单篇文章。`TypeArtiModel` 是文章集合单例，内部用 `articleDictionary` 按 `articleName` 去重。

这很重要：同名文章在首页、文章页、个人上传、详情页中应共享同一个 `ArticleModel` 实例。点赞时直接修改该实例，并发布：

```objc
@"ArticleLikedDidChange"
```

监听者包括 `HomeVC`、`ArticleVC`、`HolidayVC`、`LikeVC` 等。改点赞、文章列表或详情页时，需要确认这些页面是否仍共享同一对象。

### 复用的 Cell 和视图

- `HomeArticelCell` 虽然在 `Home/` 目录，但被首页、文章页、搜索结果、喜欢列表复用。
- `tagView` 和 `tagCell` 在搜索页和上传页复用。
- `FollowCell` 用复用标识区分关注列表和私信列表两种 UI。
- `BasicInfoCell` 用复用标识区分头像、性别、普通资料三种 UI。

改这些类时不要只验证本目录，需要按复用范围检查。

## L4：按任务阅读

### 改登录或注册

先读：

- `3GShare/Login/memory.md`
- `3GShare/Login/LoginVC.m`
- `3GShare/Login/RegisterVC.m`
- `3GShare/Login/UserInfo.m`

关注点：键盘通知生命周期、注册回填账号的 delegate、登录后 rootViewController 切换。

### 改首页、轮播或点赞同步

先读：

- `3GShare/Home/memory.md`
- `3GShare/Article/memory.md`
- `3GShare/Home/HomeHeaderCell.m`
- `3GShare/Home/HomeArticelCell.m`
- `3GShare/Article/ArticleModel.m`

关注点：轮播哑页、NSTimer 生命周期、RunLoop mode、`ArticleLikedDidChange`。

### 改文章页

先读：

- `3GShare/Article/memory.md`
- `3GShare/Home/memory.md`

关注点：三个表格通过 tag 区分数据源，横向 `UIScrollView` 和 `UISegmentedControl` 相互同步。

### 改搜索或上传

先读：

- `3GShare/Search/memory.md`
- `3GShare/Home/memory.md`

关注点：搜索结果目前只响应关键词 `大白`；上传只做本地 UI 演示，不会写入文章列表。

### 改个人中心、消息或设置

先读：

- `3GShare/Person/memory.md`
- `3GShare/Person/Message/memory.md`
- `3GShare/Person/Set/memory.md`
- `3GShare/Person/Like/memory.md`

关注点：个人菜单从 `UserInfo.info` 来，消息数字从 `MessageModel.defaultModel` 单例来，设置页只做本地交互。

## L5：约束和边界

- 这是教学 Demo，不要擅自引入网络、数据库、复杂架构或持久化，除非任务明确要求。
- Objective-C 缩进沿用现有风格，当前代码大量使用 4 空格缩进和局部中文教学注释；新增注释应服务理解，不要堆说明。
- UI 主要用 Masonry。不要混入 SwiftUI 或 Storyboard 新页面。
- 图片资源通过 `Assets.xcassets` 名称匹配，例如文章名直接作为图片名。改文章标题时要检查对应 asset 是否存在。
- `Assets.xcassets` 和 `Base.lproj` 不放 `memory.md`，避免影响资源编译和本地化资源包。
- Xcode 用户数据、DerivedData、Pods 中已有大量文件，不要为文档任务顺手清理或重排。

## L6：编译安全说明

本次新增文档分两类：

- `AI_READING_GUIDE.md` 位于仓库根目录，不在 `3GShare` target 的同步组内。
- 各模块 `memory.md` 位于源码目录内，但已写入 `3GShare.xcodeproj/project.pbxproj` 的 `membershipExceptions`，明确排除在 `3GShare` target 外。

后续如果继续新增模块文档，优先放在已有模块目录，并同步更新 `membershipExceptions`。
