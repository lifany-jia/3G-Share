//
//  ArticleModel.h
//  3GShare
//
//  Created by lifany on 2026/5/19.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface TypeArtiModel : NSObject
@property (nonatomic, strong) NSArray<ArticleModel *> *featuredArticles;
@property (nonatomic, strong) NSArray<ArticleModel *> *trendingArticles;
@property (nonatomic, strong) NSArray<ArticleModel *> *allArticles;
@property (nonatomic, strong) NSArray<ArticleModel *> *userArticles;
@property (nonatomic, strong) NSDictionary *holiday;
+ (instancetype)defaultTypeArtiModel;
@end
NS_ASSUME_NONNULL_END
