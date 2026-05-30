//
//  DmVC.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "DmVC.h"
#import "ChatVC.h"
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
    ChatVC *chat = [[ChatVC alloc] initWithTitle:self.model[indexPath.row][@"name"] ];
    [self.navigationController pushViewController:chat animated:YES];
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
