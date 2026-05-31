//
//  ArticleModel.h
//  3GShare
//
//  Created by lifany on 2026/5/19.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface ArticleModel : NSObject
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *articleName;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger views;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) BOOL liked;
+ (instancetype)modelWithAuthorName:(NSString *) authorName articleName:(NSString *) articleName time:(NSString *) time tag:(NSString *) tag likes:(NSInteger) likes views:(NSInteger) views shares:(NSInteger)shares;
@end
@interface TypeArtiModel : NSObject
@property (nonatomic, strong) NSMutableDictionary<NSString *, ArticleModel *> *articleDictionary;
@property (nonatomic, strong) NSArray<ArticleModel *> *featuredArticles;
@property (nonatomic, strong) NSArray<ArticleModel *> *trendingArticles;
@property (nonatomic, strong) NSArray<ArticleModel *> *allArticles;
@property (nonatomic, strong) NSArray<ArticleModel *> *userArticles;
@property (nonatomic, strong) NSDictionary *holiday;
+ (instancetype)defaultTypeArtiModel;
- (ArticleModel *)articleWithAuthorName:(NSString *) authorName articleName:(NSString *) articleName time:(NSString *) time tag:(NSString *) tag likes:(NSInteger) likes views:(NSInteger) views shares:(NSInteger)shares;
@end
NS_ASSUME_NONNULL_END
