//
//  HomeModel.h
//  3GShare
//
//  Created by lifany on 2026/5/18.
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
+ (instancetype)modelWithAuthorName:(NSString *) authorName articleName:(NSString *) articleName time:(NSString *) time tag:(NSString *) tag likes:(NSInteger) likes views:(NSInteger) views shares:(NSInteger)shares;
@end
@interface HomeModel : NSObject
@property (nonatomic, copy) NSArray *adImageName;
@property (nonatomic, strong) NSArray<ArticleModel *> *articles;
+ (instancetype)defaultHomeModel;
@end

NS_ASSUME_NONNULL_END
