//
//  PostVC.m
//  3GShare
//
//  Created by lifany on 2026/5/24.
//

#import "PostVC.h"
#import "tagView.h"
#import <Masonry/Masonry.h>

@interface PostVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *postView;
@property (nonatomic, strong) UIButton *dropButton;
@property (nonatomic, strong) UITableView *dropList;
@property (nonatomic, assign) BOOL isExpand;
@property (nonatomic, strong) NSArray *dropOptions;
@property (nonatomic, strong) MASConstraint *contentHeight;
@end

@implementation PostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"上传";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setupPostView];
    [self setupTagView];
}
- (void)setupPostView {
    self.postView = [[UIView alloc] init];
    self.postView.backgroundColor = [UIColor lightGrayColor];
    self.postView.layer.cornerRadius = 10;
    [self.view addSubview:self.postView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"选择图片";
    label.textColor = [UIColor whiteColor];
    [self.postView addSubview:label];
    
    [self.postView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(20);
            make.left.equalTo(self.view).offset(10);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(150);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.postView);
    }];
    
    UIImageView *GPS = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"mappin.and.ellipse"]];
    GPS.contentMode = UIViewContentModeScaleAspectFit;
    GPS.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.view addSubview:GPS];
    [GPS mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.postView).offset(30);
            make.left.equalTo(self.postView.mas_right).offset(20);
    }];
    
    UIButton *xian = [UIButton buttonWithType:UIButtonTypeCustom];
    [xian setTitle:@"陕西省，西安市" forState:UIControlStateNormal];
    [xian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xian setBackgroundColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0]];
    xian.layer.cornerRadius = 10;
    xian.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:xian];
    [xian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(GPS);
            make.left.equalTo(GPS.mas_right).offset(5);
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(25);
    }];
    
    self.dropButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButtonConfiguration *config = [UIButtonConfiguration filledButtonConfiguration];
    config.title = @"原创作品";
    config.image = [UIImage systemImageNamed:@"chevron.down"];
    config.imagePadding = 10;
    config.imagePlacement = NSDirectionalRectEdgeTrailing;
    config.baseForegroundColor = [UIColor blackColor];
    config.baseBackgroundColor = [UIColor whiteColor];
    config.background.cornerRadius = 10;
    config.preferredSymbolConfigurationForImage = [UIImageSymbolConfiguration configurationWithPointSize:12];
    config.titleTextAttributesTransformer = ^NSDictionary * (NSDictionary<NSAttributedStringKey,id> * _Nonnull incoming) {
        NSMutableDictionary *attributes = [incoming mutableCopy];
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        return attributes;
    };
    self.dropButton.configuration = config;
    self.dropButton.layer.shadowOffset = CGSizeMake(2, 2);
    self.dropButton.layer.shadowRadius = 2;
    self.dropButton.layer.shadowOpacity = 0.1;
    [self.dropButton addTarget:self action:@selector(toggleDropList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dropButton];
    [self.dropButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(xian.mas_bottom).offset(30);
            make.left.equalTo(self.postView.mas_right).offset(30);
            make.right.equalTo(self.view).offset(-30);
            make.height.mas_equalTo(30);
    }];
    
    self.dropOptions = @[
        @"原创作品", @"设计资料", @"设计教程", @"设计观点"
    ];
    self.dropList = [[UITableView alloc] init];
    self.dropList.delegate = self;
    self.dropList.dataSource = self;
    self.dropList.layer.cornerRadius = 10;
    self.dropList.rowHeight = 30;
    [self.dropList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.dropList];
    [self.dropList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dropButton.mas_bottom).offset(2);
            make.left.right.equalTo(self.dropButton);
            self.contentHeight = make.height.mas_equalTo(0); // 默认收起
    }];
    
}
- (void)setupTagView {
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor blackColor];
    divider.layer.cornerRadius = 10;
    [self.view addSubview:divider];
    [divider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.postView.mas_bottom).offset(30);
            make.left.equalTo(self.view).offset(5);
            make.right.equalTo(self.view).offset(-5);
            make.height.mas_equalTo(1);
    }];
    
    NSArray *categoryModel = @[
        @"平面设计", @"网页设计", @"UI/icon", @"虚拟与设计", @"影视", @"摄影", @"手绘/插图", @"其他"
    ];
    tagView *view = [[tagView alloc] initWithTags:categoryModel];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.postView.mas_bottom).offset(15);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(130);
    }];
}
- (void)toggleDropList {
    self.isExpand = !self.isExpand;
    CGFloat height = self.isExpand ? 30.0 * self.dropOptions.count : 0;
    if (self.isExpand) {
            [self.view bringSubviewToFront:self.dropList];
        }
    self.contentHeight.mas_equalTo(height);
    [UIView animateWithDuration:0.25 animations:^{
            self.dropButton.imageView.transform = self.isExpand ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
            [self.view layoutIfNeeded];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dropOptions.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dropOptions[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selected = self.dropOptions[indexPath.row];
    [self.dropButton setTitle:selected forState:UIControlStateNormal];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self toggleDropList];
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
