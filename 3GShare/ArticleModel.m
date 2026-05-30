//
//  ArticleModel.m
//  3GShare
//
//  Created by lifany on 2026/5/19.
//

#import "ArticleModel.h"


@implementation TypeArtiModel
+ (instancetype)defaultTypeArtiModel {
    static TypeArtiModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[TypeArtiModel alloc] init];
        model.featuredArticles = @[
            [ArticleModel modelWithAuthorName:@"share小白" articleName:@"关于设计反馈的5件事" time:@"12小时前" tag:@"设计文章-原创-理论" likes:27 views:260 shares:4],
            [ArticleModel modelWithAuthorName:@"share小王" articleName:@"用户设计PK战！脸书vs人人" time:@"1天前" tag:@"设计文章-原创-Web/Flash" likes:45 views:105 shares:20],
            [ArticleModel modelWithAuthorName:@"share小吕" articleName:@"字体故事" time:@"1天前" tag:@"设计文章-经验-设计观点" likes:145 views:347 shares:103],
            [ArticleModel modelWithAuthorName:@"share小蓝" articleName:@"5道零失败料理分享" time:@"1天前" tag:@"美食-经验" likes:108 views:567 shares:103],
            [ArticleModel modelWithAuthorName:@"share小李" articleName:@"如何做好用户体验设计" time:@"2天前" tag:@"交互设计" likes:79 views:297 shares:25],
            [ArticleModel modelWithAuthorName:@"share小李" articleName:@"如何进行竞品分析" time:@"2天前" tag:@"原创" likes:445 views:4095 shares:245],
            [ArticleModel modelWithAuthorName:@"share小米" articleName:@"提升UI设计的8个细节" time:@"3天前" tag:@"UI设计-原创" likes:156 views:1034 shares:67],
            [ArticleModel modelWithAuthorName:@"share小赵" articleName:@"设计师常用工具" time:@"4天前" tag:@"设计-工具" likes:26 views:445 shares:4]
        ];
        model.trendingArticles = @[
            [ArticleModel modelWithAuthorName:@"share小蓝" articleName:@"打造治愈系居家空间" time:@"13分钟前" tag:@"审美-家居-治愈" likes:145 views:347 shares:103],
            [ArticleModel modelWithAuthorName:@"share小明" articleName:@"每一座城都有它的故事" time:@"1小时前" tag:@"原创-人文-历史" likes:14 views:347 shares:3],
            [ArticleModel modelWithAuthorName:@"share小红" articleName:@"插花的艺术" time:@"5小时前" tag:@"设计-花卉" likes:15 views:225 shares:25],
            [ArticleModel modelWithAuthorName:@"share小绿" articleName:@"史铁生如何打造我与地坛！" time:@"21小时前" tag:@"原创-练习写作" likes:224 views:3671 shares:57],
            [ArticleModel modelWithAuthorName:@"share小白" articleName:@"旅行中的小故事" time:@"1天前" tag:@"旅行-原创" likes:15 views:327 shares:7],
            [ArticleModel modelWithAuthorName:@"share小蓝" articleName:@"5道零失败料理分享" time:@"1天前" tag:@"美食-经验" likes:108 views:567 shares:103]
        ];
        model.allArticles = @[
            [ArticleModel modelWithAuthorName:@"share小王" articleName:@"国外画册欣赏" time:@"8分钟前" tag:@"平面设计-画册设计" likes:102 views:2089 shares:38],
            [ArticleModel modelWithAuthorName:@"share小蓝" articleName:@"打造治愈系居家空间" time:@"13分钟前" tag:@"审美-家居-治愈" likes:145 views:347 shares:103],
            [ArticleModel modelWithAuthorName:@"share小吕" articleName:@"collection扁平设计" time:@"1小时前" tag:@"平面设计-海报设计" likes:78 views:1055 shares:20],
            [ArticleModel modelWithAuthorName:@"share小红" articleName:@"插花的艺术" time:@"5小时前" tag:@"设计-花卉" likes:15 views:225 shares:25],
            [ArticleModel modelWithAuthorName:@"share小绿" articleName:@"史铁生如何打造我与地坛！" time:@"21小时前" tag:@"原创-练习写作" likes:224 views:3671 shares:57],
            [ArticleModel modelWithAuthorName:@"share小李" articleName:@"如何进行竞品分析" time:@"2天前" tag:@"原创" likes:445 views:4095 shares:245],
            [ArticleModel modelWithAuthorName:@"share小蓝" articleName:@"5道零失败料理分享" time:@"1天前" tag:@"美食-经验" likes:108 views:567 shares:103],
            [ArticleModel modelWithAuthorName:@"share小白" articleName:@"设计师常用工具" time:@"4天前" tag:@"设计-工具" likes:26 views:445 shares:4]
        ];
        model.userArticles = @[
            [ArticleModel modelWithAuthorName:@"share小白" articleName:@"假日" time:@"3分钟前" tag:@"原创-插画-练习写作" likes:26 views:102 shares:13],
            [ArticleModel modelWithAuthorName:@"share小白" articleName:@"关于设计反馈的5件事" time:@"12小时前" tag:@"设计文章-原创-理论" likes:26 views:260 shares:4],
            [ArticleModel modelWithAuthorName:@"share小白" articleName:@"旅行中的小故事" time:@"1天前" tag:@"旅行-原创" likes:15 views:327 shares:7],
            [ArticleModel modelWithAuthorName:@"share小白" articleName:@"设计师常用工具" time:@"4天前" tag:@"设计-工具" likes:26 views:445 shares:4]
        ];
        model.holiday = @{
            @"content" : @"多希望列车能把我带到有你的城市",
            @"images" : @[
                @"holiday1", @"holiday2", @"holiday3", @"holiday4", @"holiday5"
            ]
        };
    });
    
    return model;
}
@end
