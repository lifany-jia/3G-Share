//
//  leftBubbleCell.h
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface leftBubbleCell : UITableViewCell
- (void)updateWithModel:(ChatModel *) model;
@end

NS_ASSUME_NONNULL_END
