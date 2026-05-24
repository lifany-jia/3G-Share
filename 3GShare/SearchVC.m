//
//  SearchVC.m
//  3GShare
//
//  Created by lifany on 2026/5/17.
//

#import "SearchVC.h"
#import "tagView.h"
#import "PostVC.h"
#import <Masonry/Masonry.h>
@interface SearchVC ()
@property (nonatomic, strong) UITextField *search;
@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIBarButtonItem *post = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"square.and.arrow.up"] style:UIBarButtonItemStylePlain target:self action:@selector(postAction)];
    self.navigationItem.rightBarButtonItem = post;

    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.clipsToBounds = YES;
    searchView.layer.cornerRadius = 20;
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.height.mas_equalTo(45);
    }];
    
    UIImageView *searchIma = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"magnifyingglass"]];
    searchIma.contentMode = UIViewContentModeScaleAspectFit;
    searchIma.tintColor = [UIColor blackColor];
    [searchView addSubview:searchIma];
    [searchIma mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(searchView);
            make.left.equalTo(searchView).offset(10);
    }];
    
    self.search = [[UITextField alloc] init];
    self.search.placeholder = @"搜索 用户名 作品分类 文章";
    [searchView addSubview:self.search];
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(searchView);
            make.left.equalTo(searchIma.mas_right).offset(10);
    }];
    NSArray *categoryModel = @[
        @"平面设计", @"网页设计", @"UI/icon", @"虚拟与设计", @"影视", @"摄影", @"手绘/插图", @"其他"
    ];
    tagView *category = [[tagView alloc] initWithTitle:@"分类" tags:categoryModel];
    [self.view addSubview:category];
    [category mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(searchView.mas_bottom).offset(30);
            make.left.right.equalTo(self.view);
        make.height.mas_equalTo(130);
    }];
    NSArray *recommandModel = @[
        @"人气最高", @"收藏最高", @"评论最多", @"编辑精选"
    ];
    tagView *recommand = [[tagView alloc] initWithTitle:@"推荐" tags:recommandModel];
    [self.view addSubview:recommand];
    [recommand mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(category.mas_bottom).offset(30);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(85);
    }];
    NSArray *timeModel = @[
        @"30分钟内", @"一天内", @"一个月内", @"一年内"
    ];
    tagView *time = [[tagView alloc] initWithTitle:@"时间" tags:timeModel];
    [self.view addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recommand.mas_bottom).offset(30);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(85);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)postAction {
    PostVC *post = [[PostVC alloc] init];
    [self.navigationController pushViewController:post animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
