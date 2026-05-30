//
//  UserInfo.h
//  3GShare
//
//  Created by lifany on 2026/5/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSArray<NSArray<NSDictionary *> *> *info;

// 本来打算用NSUserDefaults做持久化的，但是没有考虑到他不可以保存敏感信息密码这种，所以还是不做持久化了
+ (BOOL)registerWithName:(NSString *) name password:(NSString *) password email:(NSString *)email;
+ (UserInfo *)loginWithName:(NSString *)name password:(NSString *) password;
+ (instancetype)defaultUserInfo;
@end

NS_ASSUME_NONNULL_END
