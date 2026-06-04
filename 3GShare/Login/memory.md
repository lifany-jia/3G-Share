# Login 模块记忆

## 定位

登录注册模块负责首屏登录、注册回填账号、Mock 用户账户和可复用输入框。它是进入主 Tab 的唯一正式入口。

## 主要文件

- `LoginVC.*`：登录页，校验账号密码，成功后创建 TabBar。
- `RegisterVC.*`：注册页，写入内存账号字典，并通过 delegate 回填登录页账号。
- `TextFieldView.*`：带 SF Symbol 图标、分割线和输入框的复用视图。
- `UserInfo.*`：账号 Mock 和默认用户资料单例。

## 数据和状态

- 默认账号：`admin` / `123456`。
- 注册只写入 `UserInfo +account` 的静态内存字典，不持久化。
- `UserInfo defaultUserInfo` 返回固定用户资料：昵称 `share小白`、头像 `avatar`、签名、邮箱、个人中心菜单。
- 自动登录按钮只切换 selected 状态，没有真实自动登录逻辑。

## 交互流

登录页输入账号和密码，点击登录后调用 `UserInfo loginWithName:password:`。成功后 `LoginVC switchToTabBar` 创建首页、搜索、文章、活动、个人信息五个 tab，并替换 window root。

注册页输入邮箱、账号、密码后调用 `UserInfo registerWithName:password:email:`。注册成功会通过 `memorizeAccount` delegate 回填账号，然后 pop 回登录页。

## 改动注意

- `LoginVC` 的键盘监听在 `viewWillAppear` 注册，在 `viewWillDisappear` 移除，并复位 transform。
- `RegisterVC` 的键盘监听在 `viewDidLoad` 注册，在 `dealloc` 移除。
- 登录成功是直接替换 `window.rootViewController`，不是 push。
- 如果扩展真实账号体系，要先决定是否仍保留教学 Demo 的内存 Mock 边界。
