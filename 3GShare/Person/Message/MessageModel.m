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
+ (NSMutableArray<NSNumber *> *)messageSettingStates {
    static NSMutableArray<NSNumber *> *states = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        states = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i++) {
            [states addObject:@(NO)];
        }
    });
    return states;
}
+ (NSMutableArray<NSNumber *> *)followStates {
    static NSMutableArray<NSNumber *> *states = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        states = [NSMutableArray array];
        for (NSInteger i = 0; i < 6; i++) {
            [states addObject:@(NO)];
        }
    });
    return states;
}
+ (NSMutableDictionary<NSString *, NSMutableArray<ChatModel *> *> *)chatStore {
    static NSMutableDictionary<NSString *, NSMutableArray<ChatModel *> *> *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [NSMutableDictionary dictionary];
        store[@"share小格"] = @[
            [ChatModel modelWithContent:@"我是share小格" type:MessageTypeOther avatar:@"share小格"],
            [ChatModel modelWithContent:@"我是share小白" type:MessageTypeSelf avatar:@"avatar"],
            [ChatModel modelWithContent:@"你的作品我很喜欢！！！" type:MessageTypeOther avatar:@"share小格"]
        ].mutableCopy;
        store[@"share小宁"] = @[
            [ChatModel modelWithContent:@"我是share小宁" type:MessageTypeOther avatar:@"share小宁"],
            [ChatModel modelWithContent:@"你好可以问问你是怎么拍的吗？" type:MessageTypeOther avatar:@"share小宁"]
        ].mutableCopy;
        store[@"share小兰"] = @[
            [ChatModel modelWithContent:@"我是share小兰" type:MessageTypeOther avatar:@"share小兰"],
            [ChatModel modelWithContent:@"你的项链好漂亮" type:MessageTypeOther avatar:@"share小兰"],
            [ChatModel modelWithContent:@"可以给个链接吗" type:MessageTypeOther avatar:@"share小兰"]
        ].mutableCopy;
        store[@"share小汪"] = @[
            [ChatModel modelWithContent:@"快看某音给你分享的视频！！！！" type:MessageTypeSelf avatar:@"avatar"],
            [ChatModel modelWithContent:@"小白技术又精进了" type:MessageTypeOther avatar:@"share小汪"],
            [ChatModel modelWithContent:@"为你点赞！" type:MessageTypeOther avatar:@"share小汪"]
        ].mutableCopy;
    });
    return store;
}
+ (NSMutableArray<ChatModel *> *)chatMessagesForName:(NSString *)name {
    NSMutableArray<ChatModel *> *messages = [self chatStore][name];
    if (!messages) {
        messages = [NSMutableArray array];
        [self chatStore][name] = messages;
    }
    return messages;
}
+ (NSMutableArray<NSMutableDictionary *> *)dmList {
    static NSMutableArray<NSMutableDictionary *> *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [NSMutableArray array];
        [model addObject:[@{@"name" : @"share小格",
                            @"content" : @"你的作品我很喜欢！！！",
                            @"time" : @"5月28日 16:04"} mutableCopy]];
        
        [model addObject:[@{@"name" : @"share小宁",
                            @"content" : @"你好可以问问你是怎么拍的吗？",
                            @"time" : @"5月28日 09:45"} mutableCopy]];
        
        [model addObject:[@{@"name" : @"share小兰",
                            @"content" : @"可以给个链接吗",
                            @"time" : @"5月27日 23:17"} mutableCopy]];
        
        [model addObject:[@{@"name" : @"share小汪",
                            @"content" : @"为你点赞！",
                            @"time" : @"5月27日 13:54"} mutableCopy]];
    });
    return model;
}
@end
