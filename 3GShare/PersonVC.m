//
//  PersonVC.m
//  3GShare
//
//  Created by lifany on 2026/5/17.
//

#import "PersonVC.h"
#import "UserInfo.h"
#import "ArticleVC.h"
#import "SetVC.h"
#import "MessageVC.h"
#import "LikeVC.h"
#import "PersonInfoCell.h"
#import <Masonry/Masonry.h>
@interface PersonVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UserInfo *user;
@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.user = [UserInfo defaultUserInfo];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 48, 0, 10);
    [self.tableView registerClass:[PersonInfoCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self setupHeaderViewWithUserInfo:self.user];
    self.tableView.tableHeaderView = self.headerView;
}
#pragma mark - headerView
- (void)setupHeaderViewWithUserInfo:(UserInfo *) user {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    UIImageView *avator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:user.avatar]];
    avator.layer.cornerRadius = 20;
    avator.clipsToBounds = YES;
    avator.contentMode = UIViewContentModeScaleAspectFit;
    [self.headerView addSubview:avator];
    
    UILabel *name = [[UILabel alloc] init];
    name.font = [UIFont systemFontOfSize:25];
    name.textColor = [UIColor labelColor];
    name.text = user.userName;
    [self.headerView addSubview:name];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor labelColor];
    label.text = user.label;
    label.font = [UIFont systemFontOfSize:15];
    [self.headerView addSubview:label];
    
    UILabel *sign = [[UILabel alloc] init];
    sign.text = user.sign;
    sign.textColor = [UIColor labelColor];
    sign.font = [UIFont systemFontOfSize:13];
    [self.headerView addSubview:sign];
    
    UIButtonConfiguration *messageCon = [UIButtonConfiguration plainButtonConfiguration];
    messageCon.title = @"15";
    messageCon.image = [UIImage systemImageNamed:@"bubble.left.and.text.bubble.right.fill"];
    messageCon.imagePadding = 5;
    // 缩小照片
    messageCon.preferredSymbolConfigurationForImage = [UIImageSymbolConfiguration configurationWithPointSize:13];
    messageCon.titleTextAttributesTransformer = ^NSDictionary *(NSDictionary *incoming) {
        NSMutableDictionary *attributes = [incoming mutableCopy];
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        return attributes;
    };
    messageCon.baseForegroundColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    UIButton *message = [UIButton buttonWithConfiguration:messageCon primaryAction:nil];
    [self.headerView addSubview:message];
    
    UIButtonConfiguration *likeCon = [UIButtonConfiguration plainButtonConfiguration];
    likeCon.title = @"120";
    likeCon.image = [UIImage systemImageNamed:@"heart.fill"];
    likeCon.imagePadding = 3;
    likeCon.preferredSymbolConfigurationForImage = [UIImageSymbolConfiguration configurationWithPointSize:13];
    likeCon.titleTextAttributesTransformer = ^NSDictionary *(NSDictionary *incoming) {
        NSMutableDictionary *attributes = [incoming mutableCopy];
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        return attributes;
    };
    likeCon.baseForegroundColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    UIButton *like = [UIButton buttonWithConfiguration:likeCon primaryAction:nil];
    [self.headerView addSubview:like];
    
    UIButtonConfiguration *viewCon = [UIButtonConfiguration plainButtonConfiguration];
    viewCon.title = @"89";
    viewCon.image = [UIImage systemImageNamed:@"eye"];
    viewCon.imagePadding = 3;
    viewCon.preferredSymbolConfigurationForImage = [UIImageSymbolConfiguration configurationWithPointSize:13];
    viewCon.titleTextAttributesTransformer = ^NSDictionary *(NSDictionary *incoming) {
        NSMutableDictionary *attributes = [incoming mutableCopy];
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        return attributes;
    };
    viewCon.baseForegroundColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    UIButton *view = [UIButton buttonWithConfiguration:viewCon primaryAction:nil];
    [self.headerView addSubview:view];
    
    [avator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView).offset(20);
            make.left.equalTo(self.headerView).offset(20);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(avator).offset(10);
            make.left.equalTo(avator.mas_right).offset(10);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(name.mas_bottom).offset(10);
            make.left.equalTo(name);
    }];
    [sign mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(10);
            make.left.equalTo(name);
    }];
    [message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sign.mas_bottom).offset(10);
            make.left.equalTo(avator.mas_right).offset(5);
            make.bottom.equalTo(self.headerView).offset(-20);
    }];
    [like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(message);
            make.left.equalTo(message.mas_right).offset(3);
            make.bottom.equalTo(self.headerView).offset(-20);
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(message);
            make.left.equalTo(like.mas_right).offset(3);
            make.bottom.equalTo(self.headerView).offset(-20);
    }];
    [self.headerView layoutIfNeeded];
    CGSize size = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.headerView.frame = CGRectMake(0, 0, size.width, size.height);
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.user.info.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.user.info[0].count;
    } else if (section == 1) {
        return self.user.info[1].count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateWithIcon:self.user.info[indexPath.section][indexPath.row][@"icon"] name:self.user.info[indexPath.section][indexPath.row][@"title"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSArray *segName = @[@"上传时间", @"推荐最多", @"分享最多"];
            ArticleVC *article = [[ArticleVC alloc] initWithTitle:@"我的上传" segName:segName];
            [self.navigationController pushViewController:article animated:YES];
        } else if (indexPath.row == 1) {
            MessageVC *message = [[MessageVC alloc] init];
            [self.navigationController pushViewController:message animated:YES];
        } else if (indexPath.row == 2) {
            LikeVC *like = [[LikeVC alloc] init];
            [self.navigationController pushViewController:like animated:YES];
        } else {
            [self showAlert:@"目前没有新通知"];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SetVC *set = [[SetVC alloc] init];
            [self.navigationController pushViewController:set animated:YES];
        } else {
            [self showAlert:@"需求被驳回"];
        }
    }
}
- (void)showAlert:(NSString *) message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
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
