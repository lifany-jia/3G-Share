# Home 模块记忆

## 定位

首页模块展示轮播图和文章卡片，也包含假日详情页。`HomeArticelCell` 是跨模块共享 cell，影响文章页、搜索结果和喜欢列表。

## 主要文件

- `HomeVC.*`：首页表格，两段 section：轮播 header 和文章列表。
- `HomeModel.*`：首页轮播图片名和首页文章数据。
- `HomeHeaderCell.*`：轮播图 cell，负责哑页、分页和自动滚动定时器。
- `HomeArticelCell.*`：文章卡片 cell，展示图、标题、作者、标签、时间、点赞、浏览、分享。
- `HolidayVC.*`：点击首页第一条文章进入的详情页。
- `HolidayPhotoCell.*`：假日详情页图片 cell。

## 数据和状态

- 首页文章数据来自 `HomeModel defaultHomeModel`。
- `HomeModel` 会从 `TypeArtiModel defaultTypeArtiModel` 获取文章对象，确保同名文章共享实例。
- `HomeHeaderCell` 的轮播图片名是 `ad1` 到 `ad4`。
- `HolidayVC` 固定展示 `TypeArtiModel.userArticles[0]`，也就是文章 `假日`。

## 关键机制

- `HomeHeaderCell` 用首尾哑页实现无限轮播。
- 定时器在 `HomeVC tableView:willDisplayCell:` 启动，在 `didEndDisplayingCell:` 停止。
- 定时器加入 `NSRunLoopCommonModes`，避免 tableView 滚动时停摆。
- `HomeArticelCell likeSelected` 修改共享 `ArticleModel`，然后发出 `ArticleLikedDidChange` 通知。
- `HomeVC` 收到 `ArticleLikedDidChange` 后 reload 首页表格。

## 改动注意

- 改 `HomeArticelCell` 前要检查 `ArticleVC`、`SearchVC`、`LikeVC` 的复用场景。
- 改文章标题时要检查 `Assets.xcassets` 中是否有同名图片资源。
- 改轮播逻辑时要同时验证自动滚动、手动拖动、cell 复用和页面离屏。
- `HolidayVC likeChange:` 当前只同步 selected 状态，标题数字由本地点击逻辑更新。
