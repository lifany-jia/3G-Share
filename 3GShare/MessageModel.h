//
//  MessageModel.h
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger number;
+ (instancetype)modelWithTitle:(NSString *) title number:(NSInteger) number;
+ (NSMutableArray<MessageModel *> *)defaultModel;
@end

NS_ASSUME_NONNULL_END
