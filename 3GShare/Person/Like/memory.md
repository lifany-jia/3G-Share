# Person/Like 模块记忆

## 定位

我的喜欢页当前展示 `TypeArtiModel.userArticles`，不是严格意义上的“已点赞文章过滤列表”。

## 主要文件

- `LikeVC.*`：喜欢列表页。

## 数据和行为

- 数据源是 `TypeArtiModel defaultTypeArtiModel` 的 `userArticles`。
- cell 使用 `HomeArticelCell`。
- 监听 `ArticleLikedDidChange`，收到后 reload table view。
- 进入页面时隐藏 tab bar，离开时恢复。

## 改动注意

- 如果要实现真正的“我的喜欢”，需要改成从所有文章中过滤 `liked == YES`，并处理取消点赞后列表项消失。
- 当前页面和首页、文章页共享文章对象，所以点赞数字和 selected 状态会跟随通知刷新。
