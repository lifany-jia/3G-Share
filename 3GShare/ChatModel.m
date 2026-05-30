//
//  ChatModel.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "ChatModel.h"

@implementation ChatModel
+ (instancetype)modelWithContent:(NSString *)content type:(MessageType)type avatar:(NSString *)avatar {
    ChatModel *model = [[ChatModel alloc] init];
    model.content = content;
    model.type = type;
    model.avatar = avatar;
    return model;
}
@end
