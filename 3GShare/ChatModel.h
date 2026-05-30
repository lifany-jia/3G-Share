//
//  ChatModel.h
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MessageType) {
    MessageTypeSelf,
    MessageTypeOther
};
@interface ChatModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) MessageType type;
+ (instancetype)modelWithContent:(NSString *)content type:(MessageType) type avatar:(NSString *) avatar;
@end

NS_ASSUME_NONNULL_END
