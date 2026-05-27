//
//  SearchVC.m
//  3GShare
//
//  Created by lifany on 2026/5/17.
//

#import "SearchVC.h"
#import "tagView.h"
#import "PostVC.h"
#import "HomeArticelCell.h"
#import <Masonry/Masonry.h>
@interface SearchVC () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITextField *search;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<ArticleModel *> *model;
@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIBarButtonItem *post = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"square.and.arrow.up"] style:UIBarButtonItemStylePlain target:self action:@selector(postAction)];
    self.navigationItem.rightBarButtonItem = post;

    self.searchView = [[UIView alloc] init];
    self.searchView.backgroundColor = [UIColor whiteColor];
    self.searchView.clipsToBounds = YES;
    self.searchView.layer.cornerRadius = 20;
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.height.mas_equalTo(45);
    }];
    
    UIImageView *searchIma = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"magnifyingglass"]];
    searchIma.contentMode = UIViewContentModeScaleAspectFit;
    searchIma.tintColor = [UIColor blackColor];
    [self.searchView addSubview:searchIma];
    [searchIma mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.searchView);
            make.left.equalTo(self.searchView).offset(10);
    }];
    
    self.search = [[UITextField alloc] init];
    self.search.placeholder = @"搜索 用户名 作品分类 文章";
    self.search.delegate = self;
    self.search.returnKeyType = UIReturnKeySearch;
    self.search.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchView addSubview:self.search];
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.searchView);
            make.left.equalTo(searchIma.mas_right).offset(10);
    }];
    
    NSArray *categoryModel = @[
        @"平面设计", @"网页设计", @"UI/icon", @"虚拟与设计", @"影视", @"摄影", @"手绘/插图", @"其他"
    ];
    tagView *category = [[tagView alloc] initWithTitle:@"分类" tags:categoryModel];
    category.tag = 101;
    [self.view addSubview:category];
    [category mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.searchView.mas_bottom).offset(30);
            make.left.right.equalTo(self.view);
        make.height.mas_equalTo(130);
    }];
    
    NSArray *recommandModel = @[
        @"人气最高", @"收藏最高", @"评论最多", @"编辑精选"
    ];
    tagView *recommand = [[tagView alloc] initWithTitle:@"推荐" tags:recommandModel];
    recommand.tag = 102;
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
    time.tag = 103;
    [self.view addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recommand.mas_bottom).offset(30);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(85);
    }];
    
    self.model = @[
        [ArticleModel modelWithAuthorName:@"share大白" articleName:@"Icon of Baymax" time:@"3天前" tag:@"原创-UI-icon" likes:102 views:355 shares:14],
        [ArticleModel modelWithAuthorName:@"share小王" articleName:@"每个人都需要一个大白" time:@"1个月前" tag:@"原创-摄影" likes:345 views:2467 shares:40]
    ];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = YES;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.searchView.mas_bottom).offset(30);
            make.left.right.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[HomeArticelCell class] forCellReuseIdentifier:@"cell"];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)postAction {
    PostVC *post = [[PostVC alloc] init];
    [self.navigationController pushViewController:post animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self doSearch:textField.text];
    [textField resignFirstResponder];
    return YES;
}
- (void)doSearch:(NSString *) text {
    tagView* view1 = [self.view viewWithTag:101];
    tagView* view2 = [self.view viewWithTag:102];
    tagView* view3 = [self.view viewWithTag:103];
    if (text.length == 0) {
        view1.hidden = NO;
        view2.hidden = NO;
        view3.hidden = NO;
        self.tableView.hidden = YES;
    } else if (text.length != 0 && [text isEqualToString:@"大白"]) {
        view1.hidden = YES;
        view2.hidden = YES;
        view3.hidden = YES;
        self.tableView.hidden = NO;
    } else {
        view1.hidden = YES;
        view2.hidden = YES;
        view3.hidden = YES;
        self.tableView.hidden = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeArticelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateWithModel:self.model row:indexPath.row];
    return cell;
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
