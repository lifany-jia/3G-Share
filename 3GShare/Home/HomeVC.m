//
//  HomeVC.m
//  3GShare
//
//  Created by lifany on 2026/5/17.
//

#import "HomeVC.h"
#import "HomeHeaderCell.h"
#import "HolidayVC.h"
#import "HomeModel.h"
#import "HomeArticelCell.h"
@interface HomeVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeModel *model;
@end

@implementation HomeVC
- (instancetype)init {
    self = [super init];
    if (self) {
        self.model = [HomeModel defaultHomeModel];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"SHARE";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 透出的背景色浅灰色，使其看起来像分隔开
    // UIColor 的一个系统预定义颜色，专门用于分组样式表格的背景色
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // 不使用分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[HomeArticelCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[HomeHeaderCell class] forCellReuseIdentifier:@"headerCell"];
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(articleDidChange:) name:@"ArticleDidChange" object:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.model.articles.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        HomeHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell" forIndexPath:indexPath];
        [headerCell configWithModel:self.model.adImageName];
        return headerCell;
    } else if (indexPath.section == 1) {
        HomeArticelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell updateWithModel:self.model.articles row:indexPath.row];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    }
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 350;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        HolidayVC *holiday = [[HolidayVC alloc] init];
        [self.navigationController pushViewController:holiday animated:YES];
    } else {
        ArticleModel *article = self.model.articles[indexPath.row];
        article.views++;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ArticleDidChange" object:article];
        if ([article.articleName isEqualToString:@"假日"]) {
            HolidayVC *holiday = [[HolidayVC alloc] init];
            [self.navigationController pushViewController:holiday animated:YES];
        }
    }
}

// 因为我把自动轮播写在cell，定时器的开启关闭需要viewWillAppear这类函数，但是cell没有
// 所以只能通过tableView监听cell的出现和消失
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [cell isKindOfClass:[HomeHeaderCell class]]) {
        [(HomeHeaderCell *)cell startTime];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [cell isKindOfClass:[HomeHeaderCell class]]) {
        [(HomeHeaderCell *)cell stopTime];
    }
}

- (void)articleDidChange:(NSNotification *) notification {
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
