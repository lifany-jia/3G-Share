# Article 模块记忆

## 定位

文章模块管理文章数据模型和文章列表页。它是点赞同步的核心数据源，也是多个页面共享文章对象的地方。

## 主要文件

- `ArticleModel.*`：`ArticleModel` 单篇文章，`TypeArtiModel` 文章集合单例。
- `ArticleVC.*`：带 segmented control 和横向 paging scroll view 的文章列表页。

## 数据结构

`ArticleModel` 字段：

- `authorName`
- `articleName`
- `time`
- `tag`
- `likes`
- `views`
- `shares`
- `liked`

`TypeArtiModel` 字段：

- `articleDictionary`：按 `articleName` 去重，保证同名文章共享同一对象。
- `featuredArticles`
- `trendingArticles`
- `allArticles`
- `userArticles`
- `holiday`

## 页面结构

`ArticleVC initWithTitle:segName:` 支持复用标题和分段名称。主文章 tab 传入 `文章` 和 `全部文章/热门文章/精选文章`。个人中心“我的上传”也复用 `ArticleVC`，传入另一组分段标题。

`ArticleVC` 内部有三个 table view，通过 tag 判断数据源：

- `101`：`featuredArticles`
- `102`：`trendingArticles`
- `103`：`allArticles`

初始 selectedSegmentIndex 是 1，scrollView 初始 contentOffset 也放到中间页。

## 关键机制

- `UISegmentedControl` 选择时移动横向 scroll view。
- `scrollViewDidScroll:` 只处理主横向 `scr`，忽略 tableView 自身滚动。
- 收到 `ArticleLikedDidChange` 后 reload 三个 table view。
- 监听在 `viewDidLoad` 注册，`dealloc` 移除。

## 改动注意

- 文章对象共享依赖文章标题作为 key，标题不是纯展示字段。
- 新增文章分组时，需要同时维护 `numberOfRows`、`cellForRow` 和对应 tag 或重构数据源映射。
- 复用 `HomeArticelCell`，所以 cell 改动会影响多个模块。
