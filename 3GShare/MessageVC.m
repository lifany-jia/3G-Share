//
//  MessageVC.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "MessageVC.h"
#import "FollowVC.h"
#import "DmVC.h"
#import "MessageModel.h"
@interface MessageVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<MessageModel *> *message;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的消息";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    self.message = [MessageModel defaultModel];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.message.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.message[indexPath.row].title;
    cell.accessoryView = nil;
    NSInteger number = self.message[indexPath.row].number;
    if (number > 0) {
        UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        badge.textColor = [UIColor whiteColor];
        badge.backgroundColor = [UIColor redColor];
        badge.textAlignment = NSTextAlignmentCenter;
        badge.font = [UIFont systemFontOfSize:12];
        badge.layer.cornerRadius = 10;
        badge.clipsToBounds = YES;
        badge.text = [NSString stringWithFormat:@"%ld", number];
        cell.accessoryView = badge;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.message[indexPath.row].number > 0) {
        self.message[indexPath.row].number = 0;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    switch (indexPath.row) {
        case 0: {
            [self showAlert:@"目前没有新评论"];
            break;
        }
        case 1: {
            [self showAlert:@"目前没有新推荐"];
            break;
        }
        case 2: {
            FollowVC *follow = [[FollowVC alloc] init];
            [self.navigationController pushViewController:follow animated:YES];
            break;
        }
        case 3: {
            DmVC *dm = [[DmVC alloc] init];
            [self.navigationController pushViewController:dm animated:YES];
            break;
        }
        case 4: {
            [self showAlert:@"目前没有新活动"];
            break;
        }
        default:
            break;
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
