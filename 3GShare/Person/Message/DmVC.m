//
//  DmVC.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "DmVC.h"
#import "ChatVC.h"
#import "ChatModel.h"
#import "FollowCell.h"
@interface DmVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary *> *model;
@end

@implementation DmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"私信";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[FollowCell class] forCellReuseIdentifier:@"dmCell"];
    [self.view addSubview:self.tableView];
    
    self.model = @[
        @{@"name" : @"share小格", @"content" : @"你的作品我很喜欢！！！", @"time" : @"5月28日 16:04"},
        @{@"name" : @"share小宁", @"content" : @"你好可以问问你是怎么拍的吗？", @"time" : @"5月28日 09:45"},
        @{@"name" : @"share小兰", @"content" : @"可以给个链接吗", @"time" : @"5月27日 23:17"},
        @{@"name" : @"share小汪", @"content" : @"为你点赞！", @"time" : @"5月27日 13:54"}
    ];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dmCell" forIndexPath:indexPath];
    [cell updateWithModel:self.model[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *model = [NSMutableArray array];
    if (indexPath.row == 0) {
        [model addObject:[ChatModel modelWithContent:@"我是share小格" type:MessageTypeOther avatar:@"share小格"]];
        [model addObject:[ChatModel modelWithContent:@"我是share小白" type:MessageTypeSelf avatar:@"avatar"]];
        [model addObject:[ChatModel modelWithContent:@"你的作品我很喜欢！！！" type:MessageTypeOther avatar:@"share小格"]];
    } else if (indexPath.row == 1) {
        [model addObject:[ChatModel modelWithContent:@"我是share小宁" type:MessageTypeOther avatar:@"share小宁"]];
        [model addObject:[ChatModel modelWithContent:@"你好可以问问你是怎么拍的吗？" type:MessageTypeOther avatar:@"share小宁"]];
    } else if (indexPath.row == 2) {
        [model addObject:[ChatModel modelWithContent:@"我是share小兰" type:MessageTypeOther avatar:@"share小兰"]];
        [model addObject:[ChatModel modelWithContent:@"你的项链好漂亮" type:MessageTypeOther avatar:@"share小兰"]];
        [model addObject:[ChatModel modelWithContent:@"可以给个链接吗" type:MessageTypeOther avatar:@"share小兰"]];
    } else if (indexPath.row == 3) {
        [model addObject:[ChatModel modelWithContent:@"快看某音给你分享的视频！！！！" type:MessageTypeSelf avatar:@"avatar"]];
        [model addObject:[ChatModel modelWithContent:@"小白技术又精进了" type:MessageTypeOther avatar:@"share小汪"]];
        [model addObject:[ChatModel modelWithContent:@"为你点赞！" type:MessageTypeOther avatar:@"share小汪"]];
    }
    ChatVC *chat = [[ChatVC alloc] initWithTitle:self.model[indexPath.row][@"name"] model:model];
    [self.navigationController pushViewController:chat animated:YES];
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
