# Search 模块记忆

## 定位

搜索模块包含搜索页、标签筛选 UI 和上传页。当前是本地演示逻辑，没有真实搜索、筛选、发布或持久化。

## 主要文件

- `SearchVC.*`：搜索页，展示搜索框、分类/推荐/时间标签和本地搜索结果。
- `PostVC.*`：上传页，支持图片选择、标签、作品名、内容、分类下拉和发布提示。
- `tagView.*`：标签集合视图，可带标题或无标题。
- `tagCell.*`：自动宽度标签 cell，支持多选视觉状态。

## 搜索逻辑

`SearchVC doSearch:` 当前只有三种结果：

- 空文本：显示三组标签，隐藏结果表格，显示 tab bar。
- 文本等于 `大白`：隐藏标签，显示两条本地结果，隐藏 tab bar。
- 其他文本：隐藏标签和结果表格，隐藏 tab bar。

搜索结果使用 `HomeArticelCell`，数据是两个临时 `ArticleModel`，不走 `TypeArtiModel` 单例。

## 上传逻辑

`PostVC` 使用 `PHPickerViewController` 选择最多 9 张图片。图片异步加载后按原顺序放进 `images`，再刷新横向 `photoScrollView`、`UIPageControl` 和数量角标。

发布按钮只校验作品名和内容是否为空。通过校验后弹出“上传成功”，确认后 pop。不会写入首页、文章页或资源目录。

## 改动注意

- `tagView` 被搜索页和上传页共用，改布局时要验证两处高度。
- `PostVC refreshPhotoScrollView` 会追加 image view，若支持重复选图或删除图，要先清理旧 subviews。
- `dropButton` 使用 `UIButtonConfiguration`，直接 `setTitle:forState:` 可能不能更新 configuration title。
- 上传图片不进入 asset catalog，当前只在内存中展示。
