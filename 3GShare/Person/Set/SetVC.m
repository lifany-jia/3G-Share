//
//  SetVC.m
//  3GShare
//
//  Created by lifany on 2026/5/27.
//

#import "SetVC.h"
#import "SetMessageVC.h"
#import "PasswordChangeVC.h"
#import "BasicInfoVC.h"
#import <Masonry/Masonry.h>
@interface SetVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray<NSString *> *setName;
@end

@implementation SetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    self.setName = @[
        @"基本资料", @"修改密码", @"消息设置", @"关于SHARE", @"清除缓存"
    ];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 25, 0, 10);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _setName.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.setName[indexPath.row];
    cell.layoutMargins = UIEdgeInsetsMake(0, 15, 0, 0);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            BasicInfoVC *basicInfo = [[BasicInfoVC alloc] init];
            [self.navigationController pushViewController:basicInfo animated:YES];
            break;
        }
        case 1: {
            PasswordChangeVC *passwordChange = [[PasswordChangeVC alloc] init];
            [self.navigationController pushViewController:passwordChange animated:YES];
            break;
        }
        case 2: {
            SetMessageVC *viewC = [[SetMessageVC alloc] init];
            [self.navigationController pushViewController:viewC animated:YES];
            break;
        }
        case 3: {
            [self showToast:@"功能还未开发"];
            break;
        }
        case 4: {
            [self showToast:@"缓存已清除"];
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)showToast:(NSString *) message {
    UILabel *toastLabel = [[UILabel alloc] init];
    toastLabel.text = message;
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds = YES;
    toastLabel.font = [UIFont systemFontOfSize:20];
    toastLabel.textColor = [UIColor whiteColor];
    toastLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    toastLabel.textAlignment = UITextAlignmentCenter;
    toastLabel.numberOfLines = 0;
    [self.view addSubview:toastLabel];
    
    [toastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-200);
            make.width.mas_equalTo(125);
            make.height.mas_equalTo(40);
    }];
    toastLabel.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
            toastLabel.alpha = 1;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            toastLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [toastLabel removeFromSuperview];
        }];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
