//
//  MessageModel.h
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import <Foundation/Foundation.h>
#import "ChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger number;
+ (instancetype)modelWithTitle:(NSString *) title number:(NSInteger) number;
+ (NSMutableArray<MessageModel *> *)defaultModel;  // 我的消息列表
+ (NSMutableArray<NSNumber *> *)messageSettingStates; // 消息通知设置列表
+ (NSMutableArray<NSNumber *> *)followStates;  // 关注状态
+ (NSMutableArray<ChatModel *> *)chatMessagesForName:(NSString *)name; // 通过名字获得私信页消息
+ (NSMutableArray<NSMutableDictionary *> *)dmList; // 私信列表
@end

NS_ASSUME_NONNULL_END
