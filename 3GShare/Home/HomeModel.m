//
//  HomeModel.m
//  3GShare
//
//  Created by lifany on 2026/5/18.
//

#import "HomeModel.h"

@implementation HomeModel
+ (instancetype)defaultHomeModel {
    HomeModel *model = [[HomeModel alloc] init];
    model.adImageName = @[@"ad1",
                          @"ad2",
                          @"ad3",
                          @"ad4"];
    TypeArtiModel *typeModel = [TypeArtiModel defaultTypeArtiModel];
    model.articles = @[
        [typeModel articleWithAuthorName:@"share小白" articleName:@"假日" time:@"3分钟前" tag:@"原创-插画-练习写作" likes:26 views:102 shares:13],
        [typeModel articleWithAuthorName:@"share小王" articleName:@"国外画册欣赏" time:@"8分钟前" tag:@"平面设计-画册设计" likes:102 views:2089 shares:38],
        [typeModel articleWithAuthorName:@"share小吕" articleName:@"collection扁平设计" time:@"1小时前" tag:@"平面设计-海报设计" likes:78 views:1055 shares:20],
        [typeModel articleWithAuthorName:@"share小王" articleName:@"版本整理术：高效解决多风格要求" time:@"5小时前" tag:@"原创-练习写作" likes:230 views:3478 shares:103]
    ];
    return model;
}
@end
