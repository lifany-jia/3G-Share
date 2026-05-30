//
//  FollowVC.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "FollowVC.h"
#import "FollowCell.h"
@interface FollowVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *model;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *isSelected;
@end

@implementation FollowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新关注的";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[FollowCell class] forCellReuseIdentifier:@"followCell"];
    [self.view addSubview:self.tableView];
    
    self.model = @[
        @"share小格", @"share小宁", @"share小黑", @"shareLily", @"share小兰", @"share小汪"
    ];
    for (int i = 0; i < self.model.count; i++) {
        [self.isSelected addObject:@(NO)];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"followCell" forIndexPath:indexPath];
    BOOL isSelect = self.isSelected[indexPath.row];
    [cell updateWithFollowModel:self.model[indexPath.row] isSelectedd:isSelect];
    cell.followBlock = ^(BOOL isFollowed){
        self.isSelected[indexPath.row] = @(isFollowed);
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
