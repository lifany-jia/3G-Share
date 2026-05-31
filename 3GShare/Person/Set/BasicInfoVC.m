//
//  BasicInfoVC.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "BasicInfoVC.h"
#import "BasicInfoCell.h"
#import "UserInfo.h"
@interface BasicInfoVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserInfo *user;
@property (nonatomic, strong) NSArray<NSDictionary *> *model;
@end

@implementation BasicInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"基本资料";
    
    self.user = [UserInfo defaultUserInfo];
    
    self.model = @[
        @{@"title" : @"昵称", @"content" : self.user.userName},
        @{@"title" : @"签名", @"content" : self.user.sign},
        @{@"title" : @"邮箱", @"content" : self.user.email}
    ];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[BasicInfoCell class] forCellReuseIdentifier:@"avatarCell"];
    [self.tableView registerClass:[BasicInfoCell class] forCellReuseIdentifier:@"infoCell"];
    [self.tableView registerClass:[BasicInfoCell class] forCellReuseIdentifier:@"genderCell"];
    [self.view addSubview:self.tableView];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicInfoCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"avatarCell" forIndexPath:indexPath];
        [cell updateWithTitle:@"头像" avatar:self.user.avatar];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"genderCell" forIndexPath:indexPath];
        [cell updateWithTitle:@"性别" isFemale:YES];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        [cell updateWithTitle:self.model[indexPath.row - 2][@"title"] content:self.model[indexPath.row - 2][@"content"]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    } else {
        return 60;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
