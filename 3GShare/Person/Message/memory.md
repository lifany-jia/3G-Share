# Person/Message 模块记忆

## 定位

消息模块负责个人中心里的消息总入口、新关注列表、私信列表和聊天页。全部数据都是本地 Mock。

## 主要文件

- `MessageModel.*`：消息入口的标题和未读数单例。
- `MessageVC.*`：消息分类列表。
- `FollowVC.*`：新关注列表。
- `FollowCell.*`：复用为关注 cell 和私信 cell。
- `DmVC.*`：私信会话列表。
- `ChatModel.*`：聊天消息模型。
- `ChatVC.*`：聊天详情页。
- `leftBubbleCell.*`：对方消息气泡。
- `RightBubbleCell.*`：自己消息气泡。

## 消息入口

`MessageModel defaultModel` 用 `dispatch_once` 返回可变数组。初始未读数：

- 评论：0
- 推荐我的：0
- 新关注的：6
- 私信：4
- 活动通知：0

点击有未读数的行会先清零并 reload 当前行，再根据行号进入子页面或弹 alert。

## 关注和私信

`FollowVC` 用本地用户名数组展示新关注用户，并用 `isSelected` 数组保存回关状态。`FollowCell` 通过 `followBlock` 把按钮 selected 状态回传给 VC。

`DmVC` 用本地字典数组展示私信摘要，点击后根据 index 手动构造聊天消息数组，再 push `ChatVC`。

## 聊天

`ChatVC` 使用 `ChatModel` 数组作为数据源。发送消息时当前实现随机决定是自己消息还是对方消息，并追加到 table view。键盘变化通过更新 `inputBarBottom` 约束同步移动输入栏和消息列表。

## 改动注意

- `FollowCell` 按 reuseIdentifier 分支创建 UI：`followCell` 和 `dmCell`。
- 聊天页在 `viewWillAppear` 注册键盘通知，在 `viewWillDisappear` 移除。
- 如果改成真实聊天，先移除随机 `MessageType`，并明确消息归属和持久化边界。
