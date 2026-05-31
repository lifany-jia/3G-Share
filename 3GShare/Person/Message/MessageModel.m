//
//  MessageModel.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "MessageModel.h"

@implementation MessageModel
+ (instancetype)modelWithTitle:(NSString *)title number:(NSInteger)number {
    MessageModel *model = [[MessageModel alloc] init];
    model.title = title;
    model.number = number;
    return model;
}
+ (NSMutableArray<MessageModel *> *)defaultModel {
    static NSMutableArray<MessageModel *> *message = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        message = @[
            [MessageModel modelWithTitle:@"评论"    number:0],
            [MessageModel modelWithTitle:@"推荐我的" number:0],
            [MessageModel modelWithTitle:@"新关注的" number:6],
            [MessageModel modelWithTitle:@"私信"    number:4],
            [MessageModel modelWithTitle:@"活动通知" number:0]
        ].mutableCopy;
    });
    return message;
}
@end
