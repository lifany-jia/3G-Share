//
//  ChatVC.h
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChatVC : UIViewController
@property (nonatomic, copy) void(^modifyLastMessage)(NSString *message);
- (instancetype)initWithTitle:(NSString *) title model:(NSMutableArray<ChatModel *> *) model;
@end

NS_ASSUME_NONNULL_END
