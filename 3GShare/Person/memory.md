# Person 模块记忆

## 定位

个人中心模块展示用户资料、统计按钮和功能菜单，并路由到上传文章、消息、喜欢、设置等子模块。

## 主要文件

- `PersonVC.*`：个人中心首页。
- `PersonInfoCell.*`：个人中心菜单 cell。
- `Like/`：我的喜欢子模块。
- `Message/`：消息、关注、私信和聊天子模块。
- `Set/`：设置子模块。

## 数据

`PersonVC` 使用 `UserInfo defaultUserInfo`：

- header 展示头像、昵称、标签、签名。
- 菜单来自 `user.info`，分两组。

统计按钮里的消息数、喜欢数、浏览数是固定展示值，不随其他模块变化。

## 路由

第一组菜单：

- `我的上传`：push `ArticleVC`，传入 `上传时间/推荐最多/分享最多` 分段标题。
- `我的消息`：push `MessageVC`。
- `我的喜欢`：push `LikeVC`。
- `院系通知`：弹出“目前没有新通知”。

第二组菜单：

- `设置`：push `SetVC`。
- `退出`：弹出“需求被驳回”。

## 改动注意

- 菜单文案和图标来自 `UserInfo.info`，不是 `PersonVC` 本地数组。
- `PersonVC` 用 `tableHeaderView` 承载 header，修改 header 后要重新计算 frame。
- 子页面通常在 `viewWillAppear` 隐藏 tab bar，在 `viewWillDisappear` 恢复。
