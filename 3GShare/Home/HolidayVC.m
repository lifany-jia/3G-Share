//
//  HolidayVC.m
//  3GShare
//
//  Created by lifany on 2026/5/20.
//

#import "HolidayVC.h"
#import "ArticleModel.h"
#import "HolidayPhotoCell.h"
#import "UserInfo.h"
#import <Masonry/Masonry.h>
@interface HolidayVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TypeArtiModel *model;
@property (nonatomic, strong) UserInfo *user;
@property (nonatomic, strong) UIButton *like;
@property (nonatomic, strong) UIButton *views;
@property (nonatomic, strong) UIButton *shares;
@property (nonatomic, strong) ArticleModel *article;
@end

@implementation HolidayVC
- (instancetype)init {
    self = [super init];
    if (self) {
        self.model = [TypeArtiModel defaultTypeArtiModel];
        self.user = [UserInfo defaultUserInfo];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"假日";
    self.article = self.model.userArticles[0];
    
#pragma mark - headerView
    self.headerView = [[UIView alloc] init];
    UIImage *ava = [UIImage imageNamed:self.user.avatar];
    UIImageView *avaImaV = [[UIImageView alloc] initWithImage:ava];
    [self.headerView addSubview:avaImaV];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(100);
    }];
    
    UILabel *name = [[UILabel alloc] init];
    name.font = [UIFont systemFontOfSize:25];
    name.text = self.user.userName;
    name.textColor = [UIColor labelColor];
    [self.headerView addSubview:name];
    
    UILabel *articleName = [[UILabel alloc] init];
    articleName.font = [UIFont systemFontOfSize:21];
    articleName.text = self.model.userArticles[0].articleName;
    articleName.textColor = [UIColor labelColor];
    [self.headerView addSubview:articleName];
    
    UILabel *time = [[UILabel alloc] init];
    time.font = [UIFont systemFontOfSize:15];
    time.text = self.model.userArticles[0].time;
    time.textColor = [UIColor secondaryLabelColor];
    [self.headerView addSubview:time];
    
    self.like = [UIButton buttonWithType:UIButtonTypeCustom];
    self.like.selected = self.article.liked;
    [self.like setImage:[UIImage systemImageNamed:@"heart" ]forState:UIControlStateNormal];
    [self.like setImage:[UIImage systemImageNamed:@"heart.fill" ]forState:UIControlStateSelected];
    [self.like setTitle:[NSString stringWithFormat:@"%ld", (long)self.model.userArticles[0].likes] forState:UIControlStateNormal];
    [self.like addTarget:self action:@selector(likeAction) forControlEvents:UIControlEventTouchUpInside];
    self.like.titleLabel.font = [UIFont systemFontOfSize:14];
    self.like.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.like setTitleColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.headerView addSubview:self.like];
    
    self.views = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.views setImage:[UIImage systemImageNamed:@"eye"] forState:UIControlStateNormal];
    [self.views setTitle:[NSString stringWithFormat:@"%ld", (long)self.model.userArticles[0].views] forState:UIControlStateNormal];
    self.views.titleLabel.font = [UIFont systemFontOfSize:14];
    self.views.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.views setTitleColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.headerView addSubview:self.views];
    
    self.shares = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shares setImage:[UIImage systemImageNamed:@"arrowshape.turn.up.right"] forState:UIControlStateNormal];
    [self.shares setTitle:[NSString stringWithFormat:@"%ld", (long)self.model.userArticles[0].shares] forState:UIControlStateNormal];
    self.shares.titleLabel.font = [UIFont systemFontOfSize:14];
    self.shares.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.shares setTitleColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.headerView addSubview:self.shares];
    
    
    [avaImaV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView);
            make.left.equalTo(self.headerView);
            make.bottom.equalTo(self.headerView);
            make.width.mas_offset(100);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView).offset(15);
            make.left.equalTo(avaImaV.mas_right).offset(10);
    }];
    [articleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headerView).offset(-15);
            make.left.equalTo(name);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(name);
            make.right.equalTo(self.headerView).offset(-10);
    }];
    [self.shares mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headerView).offset(-15);
            make.right.equalTo(time);
    }];
    [self.views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shares);
            make.right.equalTo(self.shares.mas_left).offset(-15);
            make.width.mas_equalTo(60);
    }];
    [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shares);
            make.right.equalTo(self.views.mas_left).offset(-15);
            make.width.mas_equalTo(50);
    }];
#pragma mark - Divider
    UIView *divider = [[UIView alloc] init];
    // 系统自动适配深色模式的分割线颜色
    divider.backgroundColor = [UIColor separatorColor];
    [self.view addSubview:divider];
    [divider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_bottom);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view).offset(-10);
            make.height.mas_equalTo(0.5);
    }];
#pragma mark - ContentView
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(divider.mas_bottom);
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.bottom.equalTo(self.view);
    }];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    UILabel *content = [[UILabel alloc] init];
    content.text = self.model.holiday[@"content"];
    content.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(contentView).insets(UIEdgeInsetsMake(12, 0, 0, 0));
    }];
    self.tableView.tableHeaderView = contentView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = NO;
    self.tableView.estimatedRowHeight = 200;
    [self.tableView registerClass:[HolidayPhotoCell class] forCellReuseIdentifier:@"cell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(articleDidChange:) name:@"ArticleDidChange" object:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 因为这里的self.model.holiday是一个字典，字典的value是id类型
    // 可以对id类型进行方法，但是不可以使用属性count，所以要先转化一下类型
    NSArray *images = self.model.holiday[@"images"];
    return images.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HolidayPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateWithModel:self.model.holiday[@"images"] index:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)likeAction {
    self.article.liked = !self.article.liked;
    if (self.article.liked) {
        self.article.likes++;
    } else {
        self.article.likes--;
    }
    self.like.selected = self.article.liked;
    [self.like setTitle:[NSString stringWithFormat:@"%ld", self.article.likes]
                     forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ArticleDidChange" object:self.article];
}
- (void)articleDidChange:(NSNotification *) notification {
    self.like.selected = self.article.liked;
    [self.like setTitle:[NSString stringWithFormat:@"%ld", (long)self.article.likes] forState:UIControlStateNormal];
    [self.views setTitle:[NSString stringWithFormat:@"%ld", (long)self.article.views] forState:UIControlStateNormal];
    [self.shares setTitle:[NSString stringWithFormat:@"%ld", (long)self.article.shares] forState:UIControlStateNormal];
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
