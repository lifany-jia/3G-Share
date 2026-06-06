# Person/Set 模块记忆

## 定位

设置模块包含设置入口、基本资料、修改密码和消息设置。当前均为本地 UI 演示，不修改真实用户状态。

## 主要文件

- `SetVC.*`：设置列表页。
- `BasicInfoVC.*`：基本资料展示页。
- `BasicInfoCell.*`：头像、性别、普通资料三种 cell。
- `PasswordChangeVC.*`：密码修改表单。
- `SetMessageVC.*`：消息通知开关列表。

## 设置入口

`SetVC` 本地数组：

- 基本资料
- 修改密码
- 消息设置
- 关于SHARE
- 清除缓存

前三项 push 子页面，关于 SHARE 弹“功能还未开发”，清除缓存弹 toast。

## 基本资料

`BasicInfoVC` 使用 `UserInfo defaultUserInfo` 展示头像、性别、昵称、签名、邮箱。`BasicInfoCell` 根据 reuseIdentifier 决定创建头像、性别或普通资料 UI。

## 密码修改

`PasswordChangeVC` 有旧密码、新密码、确认密码三个输入框，只校验非空和新密码一致。成功后 alert 确认再 pop，不会写入 `UserInfo.account`。

## 消息设置

`SetMessageVC` 用 `selectedStatues` 保存 5 个本地开关状态，点击 cell 切换 square/checkmark 图标。

## 改动注意

- 所有设置子页都会隐藏 tab bar，离开后恢复。
- 若实现真实资料或密码修改，需要新增状态保存路径，目前模块只展示 UI。
- `BasicInfoCell` 的 UI 初始化依赖 reuseIdentifier，新增类型时要同步注册和分支。
