//
//  UserInfo.m
//  3GShare
//
//  Created by lifany on 2026/5/14.
//

#import "UserInfo.h"

@implementation UserInfo
+ (NSMutableDictionary *)account {
    // 静态字典，整个 App 生命周期只初始化一次
    // 静态变量不能在声明时用函数/方法调用赋值，只能赋值编译时确定的常量
    static NSMutableDictionary *account = nil;
    if (!account) {
        account = [NSMutableDictionary dictionary];
        account[@"admin"] = @"123456";
    }
    return account;
    
}
+ (BOOL)registerWithName:(NSString *)name password:(NSString *)password email:(NSString *)email {
    if ([self account][name]) {
        // 账户存在
        return NO;
    }
    [self account][name] = password;
    return YES;
}
+ (UserInfo *)loginWithName:(NSString *)name password:(NSString *)password {
    NSString *userPassword = [self account][name];
    if (!userPassword) {
        return nil;
    }
    if (![userPassword isEqualToString:password]) {
        return nil;
    }
    UserInfo *user = [UserInfo defaultUserInfo];
    return user;
}
+ (instancetype)defaultUserInfo {
    static UserInfo *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[UserInfo alloc] init];
        user.userName = @"share小白";
        user.avatar = @"avatar";
        user.sign = @"开心了就笑，不开心了就过会儿再笑";
        user.label = @"数媒/设计爱好者";
        user.email = @"186###3@qq.com";
        user.info = @[
        @[
            @{@"title": @"我的上传", @"icon": @"square.and.arrow.up"},
            @{@"title": @"我的消息", @"icon": @"bubble"},
            @{@"title": @"我的喜欢", @"icon": @"heart.fill"},
            @{@"title": @"院系通知", @"icon": @"graduationcap"}
        ],
        @[
            @{@"title": @"设置", @"icon": @"gearshape"},
            @{@"title": @"退出", @"icon": @"rectangle.portrait.and.arrow.right"},
        ]
        ];
    });
    return user;
}

@end
