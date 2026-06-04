# Task 模块记忆

## 定位

活动模块展示本地活动列表，是一个简单的 table view + 动态图片高度练习页。

## 主要文件

- `TaskVC.*`：活动列表页。
- `TaskCell.*`：活动卡片 cell。

## 数据

`TaskVC` 在 `viewDidLoad` 中写死两组数组：

- 图片名：`冰淇淋`、`小李家`、`插画大赛`、`防晒霜`
- 文案：四条本地活动标题

图片名对应 `Assets.xcassets/task` 下的 imageset。

## 布局

`TaskCell` 用白色圆角容器包住图片和标题。图片高度根据原图宽高比和屏幕宽度动态更新，table view 使用 automatic dimension。

## 改动注意

- 新增活动时要同步增加图片 asset 和文案数组，两个数组数量必须一致。
- `TaskCell` 当前没有点击详情页。
- 这是展示型模块，不涉及共享模型或通知。
