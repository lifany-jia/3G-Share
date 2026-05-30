//
//  FollowCell.h
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FollowCell : UITableViewCell
// 添加回调，在button的selected改变的时候通知tableView对选择状态的数组进行修改
// 需要对选择的状态进行保存是为了在 Cell 复用时展示正确的选择状态，而不是使用默认值或其他 Cell 留下的旧数据
// 其实如果cell的数量都没有占满屏幕的情况是不需要的，以为不会有cell复用的问题
@property (nonatomic, copy) void (^followBlock)(BOOL isFollowed);
- (void)updateWithFollowModel:(NSString *) model isSelectedd:(BOOL) isSelected;
- (void)updateWithModel:(NSDictionary *) model;
@end

NS_ASSUME_NONNULL_END
