//
//  TaskVC.m
//  3GShare
//
//  Created by lifany on 2026/5/17.
//

#import "TaskVC.h"
#import "TaskCell.h"
@interface TaskVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imaName;
@property (nonatomic, strong) NSArray *labelName;
@end

@implementation TaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动";
    
    self.imaName = @[@"冰淇淋", @"小李家", @"插画大赛", @"防晒霜"];
    self.labelName = @[@"GoGo冰淇淋开业啦！！！GoGo！！！", @"小李家蓝莓新品劲爆来袭！", @"用画笔描绘梦想，让世界看见你的色彩", @"阳光守护防晒霜夏日特惠！买一送一活动上线"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[TaskCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imaName.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateWithImaName:self.imaName label:self.labelName row:indexPath.row];
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
