//
//  PostVC.m
//  3GShare
//
//  Created by lifany on 2026/5/24.
//

#import "PostVC.h"
#import "tagView.h"
#import <PhotosUI/PhotosUI.h>
#import <Masonry/Masonry.h>

@interface PostVC () <UITableViewDelegate, UITableViewDataSource, PHPickerViewControllerDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIView *postView;
@property (nonatomic, strong) UIButton *dropButton;
@property (nonatomic, strong) UIButton *postButton;
@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *contentText;
@property (nonatomic, strong) UITableView *dropList;
@property (nonatomic, assign) BOOL isExpand;
@property (nonatomic, strong) NSArray *dropOptions;
@property (nonatomic, strong) NSMutableArray<UIImage *> *images;
@property (nonatomic, strong) MASConstraint *contentHeight;
@property (nonatomic, strong) UIScrollView *photoScrollView;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) UILabel *badgeLabel;
@end

@implementation PostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"上传";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.images = [NSMutableArray array];
    [self setupPostView];
    [self setupTagView];
    [self setupTextField];
    
}
#pragma mark - setupPostView
- (void)setupPostView {
    self.postView = [[UIView alloc] init];
    self.postView.backgroundColor = [UIColor lightGrayColor];
    self.postView.layer.cornerRadius = 10;
    self.postView.clipsToBounds = YES;
    [self.view addSubview:self.postView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"选择图片";
    label.tag = 101;
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto)];
    [self.postView addGestureRecognizer:tap];
    self.postView.userInteractionEnabled = YES;
    
    self.photoScrollView = [[UIScrollView alloc] init];
    // 没有设置contentSize之前和普通UIView一样，不会显示
    self.photoScrollView.pagingEnabled = YES;
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoScrollView.delegate = self;
    [self.postView addSubview:self.photoScrollView];
    [self.photoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.postView);
    }];
    
    self.page = [[UIPageControl alloc] init];
    self.page.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.page.pageIndicatorTintColor = [UIColor lightGrayColor];
    // 没有数量之前不会显示
    self.page.hidesForSinglePage = YES;
    [self.postView addSubview:self.page];
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.postView).offset(-5);
            make.centerX.equalTo(self.postView);
    }];
    
    self.badgeLabel = [[UILabel alloc] init];
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.backgroundColor = [UIColor redColor];
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    self.badgeLabel.font = [UIFont systemFontOfSize:12];
    self.badgeLabel.layer.cornerRadius = 10;
    self.badgeLabel.clipsToBounds = YES;
    // 隐藏起来
    self.badgeLabel.hidden = YES;
    [self.postView addSubview:self.badgeLabel];
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.postView).offset(5);
            make.right.equalTo(self.postView).offset(-5);
            make.width.height.mas_equalTo(20);
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
    xian.titleLabel.font = [UIFont systemFontOfSize:14];
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
    // 设置图标固定 12pt，不受字体影响
    config.preferredSymbolConfigurationForImage = [UIImageSymbolConfiguration configurationWithPointSize:12];
    // 修改字体
    config.titleTextAttributesTransformer = ^NSDictionary * (NSDictionary<NSAttributedStringKey,id> * _Nonnull incoming) {
        // incoming 系统默认的文字属性字典
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

#pragma mark - setupTagView
- (void)setupTagView {
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor grayColor];
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
#pragma mark - setupTextField
- (void)setupTextField {
    UIView *nameView = [[UIView alloc] init];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.postView.mas_bottom).offset(150);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(30);
    }];
    self.nameText = [[UITextField alloc] init];
    self.nameText.placeholder = @"作品名称";
    [self.view addSubview:self.nameText];
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameView);
            make.left.equalTo(nameView).offset(15);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameView.mas_bottom).offset(20);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(100);
    }];
    self.contentText = [[UITextField alloc] init];
    self.contentText.placeholder = @"请添加作品说明/文章内容......";
    [self.view addSubview:self.contentText];
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).offset(10);
            make.left.equalTo(contentView).offset(15);
    }];
    
    UIButtonConfiguration *config = [UIButtonConfiguration filledButtonConfiguration];
    config.title = @"发布作品";
    config.baseBackgroundColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    config.titleTextAttributesTransformer = ^NSDictionary * (NSDictionary *incoming) {
        NSMutableDictionary *attributes = [incoming mutableCopy];
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:23];
        return attributes;
    };
    self.postButton = [UIButton buttonWithConfiguration:config primaryAction:nil];
    [self.postButton addTarget:self action:@selector(postAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.postButton];
    [self.postButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *banDownLoad = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *unchecked = [[UIImage systemImageNamed:@"circle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *checked = [[UIImage systemImageNamed:@"record.circle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [banDownLoad setImage:unchecked forState:UIControlStateNormal];
    // 这里只有当按钮处于selected的状态才会变化，所以还得添加一个点击事件来改变这个状态
    [banDownLoad setImage:checked forState:UIControlStateSelected];
    [banDownLoad setTitle:@"禁止下载" forState:UIControlStateNormal];
    banDownLoad.titleLabel.font = [UIFont systemFontOfSize:15];
    [banDownLoad setTitleColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [banDownLoad addTarget:self action:@selector(banDownLoadAction:) forControlEvents:UIControlEventTouchUpInside];
    banDownLoad.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.view addSubview:banDownLoad];
    [banDownLoad mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.postButton.mas_bottom).offset(10);
            make.left.equalTo(self.postButton).offset(10);
    }];
    
}
#pragma mark - action
- (void)banDownLoadAction:(UIButton *)but {
    but.selected = !but.selected;
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isExpand) {
        [self toggleDropList];
    }
    [self.view endEditing:YES];
}
- (void)selectPhoto {
    PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
    config.filter = [PHPickerFilter imagesFilter];
    config.selectionLimit = 9;
    PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:config];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (results.count == 0) {
        return ;
    }
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray *newImages = [NSMutableArray array];
    for (PHPickerResult *result in results) {
        dispatch_group_enter(group);
        [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(UIImage *image, NSError *error) {
            if (image) {
                @synchronized (newImages) {
                    [newImages addObject:image];
                }
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.images addObjectsFromArray:newImages];
        [self refreshPhotoScrollView];
    });
}
- (void)refreshPhotoScrollView {
    NSLog(@"%ld", self.images.count);
    NSLog(@"postView bounds: %@", NSStringFromCGRect(self.postView.bounds));
    CGFloat width = self.postView.bounds.size.width;
    CGFloat height = self.postView.bounds.size.height;
    for (int i = 0; i < self.images.count; i++) {
        UIImageView *imaV = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        imaV.image = self.images[i];
        imaV.contentMode = UIViewContentModeScaleToFill;
        imaV.clipsToBounds = YES;
        [self.photoScrollView addSubview:imaV];
    }
    self.photoScrollView.contentSize = CGSizeMake(width * self.images.count, height);
    self.page.numberOfPages = self.images.count;
    self.badgeLabel.hidden = self.images.count == 0;
    self.badgeLabel.text = [NSString stringWithFormat:@"%ld", self.images.count];
    [self.postView bringSubviewToFront:self.badgeLabel];
    [self.postView bringSubviewToFront:self.page];
}
- (void)postAction {
    NSString *name = self.nameText.text;
    NSString *content = self.contentText.text;
    if (name.length == 0 || content.length == 0) {
        UIAlertController *alertCancel = [UIAlertController alertControllerWithTitle:@"提示" message:@"名称或内容不能为空！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertCancel addAction:cancel];
        [self presentViewController:alertCancel animated:YES completion:nil];
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传成功！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - tableView
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = scrollView.bounds.size.width;
    CGFloat x = scrollView.contentOffset.x;
    NSInteger page = (NSInteger)((x / width) + 0.5);
    self.page.currentPage = page;
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
