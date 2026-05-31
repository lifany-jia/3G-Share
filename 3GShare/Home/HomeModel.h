//
//  HomeModel.h
//  3GShare
//
//  Created by lifany on 2026/5/18.
//

#import <Foundation/Foundation.h>
#import "ArticleModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface HomeModel : NSObject
@property (nonatomic, copy) NSArray *adImageName;
@property (nonatomic, strong) NSArray<ArticleModel *> *articles;
+ (instancetype)defaultHomeModel;
@end

NS_ASSUME_NONNULL_END
