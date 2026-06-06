# 3GShare 模块记忆

## 定位

这里是 App 外壳和跨模块上下文，不是单一业务页面。启动、Info 配置、全局资源和 target 同步组都从这里展开。

## 主要文件

- `main.m`：UIApplication 入口。
- `AppDelegate.*`：保留默认生命周期实现，当前没有业务逻辑。
- `SceneDelegate.*`：创建 window，设置登录页为首屏。
- `Info.plist`：Scene 配置文件。工程 build settings 同时启用了 generated Info.plist。
- `Assets.xcassets`：图片和颜色资源。
- `Base.lproj`：默认 Main 和 LaunchScreen storyboard。实际首屏由 `SceneDelegate` 程序化设置。

## 运行路径

`SceneDelegate` 创建 `UIWindow`，设置蓝色背景，创建 `LoginVC`，再包一层 `UINavigationController` 作为 root。登录成功后由 `LoginVC` 替换 window root 为 5 tab 结构。

## 跨模块约定

- 统一使用 UIKit + Objective-C。
- 主要布局库是 Masonry。
- 文章点赞通知名是 `ArticleLikedDidChange`。
- 默认用户资料来自 `UserInfo defaultUserInfo`。
- 文章共享数据来自 `TypeArtiModel defaultTypeArtiModel`。

## Xcode 文档安全

`3GShare/` 是 Xcode 文件系统同步根组。放在本目录或子目录的 Markdown 可能被 Xcode 发现，所以 `memory.md` 文件必须在 `project.pbxproj` 的 `membershipExceptions` 中排除，不能加入 Sources 或 Resources。

不要在 `Assets.xcassets` 或 `Base.lproj` 内新增 `memory.md`。
