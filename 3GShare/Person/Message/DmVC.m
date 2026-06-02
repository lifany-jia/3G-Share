//
//  DmVC.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "DmVC.h"
#import "ChatVC.h"
#import "FollowCell.h"
#import "MessageModel.h"
@interface DmVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *model;
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
    
    self.model = [MessageModel dmList];
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
    NSString *name = self.model[indexPath.row][@"name"];
    NSMutableArray<ChatModel *> *model = [MessageModel chatMessagesForName:name];
    ChatVC *chat = [[ChatVC alloc] initWithTitle:name model:model];
    __weak typeof(self) weakSelf = self;
    chat.modifyLastMessage = ^(NSString *message) {
        weakSelf.model[indexPath.row][@"content"] = message;
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        [tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
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
