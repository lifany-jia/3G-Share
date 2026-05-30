//
//  SetMessageVC.m
//  3GShare
//
//  Created by lifany on 2026/5/27.
//

#import "SetMessageVC.h"
#import <Masonry/Masonry.h>
@interface SetMessageVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *name;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *selectedStatues;
@end

@implementation SetMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息设置";
    
    self.name = @[
        @"接受新消息通知", @"通知显示栏", @"声音", @"振动", @"关注更新"
    ];
    
    self.selectedStatues = [NSMutableArray array];
    for (int i = 0; i < self.name.count; i++) {
        [self.selectedStatues addObject:@(NO)];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.name.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.name[indexPath.row];
    
    cell.accessoryView = nil;
    
    UIImageView *imaV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    BOOL isSelected = [self.selectedStatues[indexPath.row] boolValue];
    imaV.image = [UIImage systemImageNamed:isSelected ? @"checkmark.square.fill" : @"square"];
    imaV.tintColor = [UIColor colorWithRed:53.0/255.0 \
                                     green:143.0/255.0 \
                                      blue:203.0/255.0 \
                                     alpha:1.0];
    imaV.contentMode = UIViewContentModeScaleAspectFit;
    cell.accessoryView = imaV;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BOOL isSelected = [self.selectedStatues[indexPath.row] boolValue];
    self.selectedStatues[indexPath.row] = @(!isSelected);
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
