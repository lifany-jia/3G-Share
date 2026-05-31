//
//  ArticleVC.m
//  3GShare
//
//  Created by lifany on 2026/5/17.
//

#import "ArticleVC.h"
#import "HomeArticelCell.h"
#import <Masonry/Masonry.h>
@interface ArticleVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *featuredView;
@property (nonatomic, strong) UITableView *trendingView;
@property (nonatomic, strong) UITableView *allArticleView;
@property (nonatomic, strong) UIScrollView *scr;
@property (nonatomic, strong) UISegmentedControl *titleSeg;
@property (nonatomic, strong) TypeArtiModel *model;
@property (nonatomic, copy) NSArray<NSString *> * segName;
@property (nonatomic, copy) NSString *titleName;
@end

@implementation ArticleVC
- (instancetype)initWithTitle:(NSString *)title segName:(NSArray<NSString *> *)segName {
    self = [super init];
    if (self) {
        self.model = [TypeArtiModel defaultTypeArtiModel];
        self.titleName = title;
        self.segName = segName;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleName;
    // seg 背景透明，透出玻璃效果
    self.titleSeg.backgroundColor = [UIColor clearColor];
    self.titleSeg = [[UISegmentedControl alloc] init];
    [self.titleSeg insertSegmentWithTitle:self.segName[0] atIndex:0 animated:YES];
    [self.titleSeg insertSegmentWithTitle:self.segName[1] atIndex:1 animated:YES];
    [self.titleSeg insertSegmentWithTitle:self.segName[2] atIndex:2 animated:YES];
    [self.view addSubview:self.titleSeg];
    [self.titleSeg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    self.titleSeg.selectedSegmentIndex = 1;
    
    [self.titleSeg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(50);
    }];
    
    CGFloat screenWidth = self.view.bounds.size.width;
    self.scr = [[UIScrollView alloc] init];
    self.scr.pagingEnabled = YES;
    self.scr.delegate = self;
    self.scr.bounces = NO;
    self.scr.showsHorizontalScrollIndicator = NO;
    self.scr.contentOffset = CGPointMake(screenWidth, 0);
    [self.view addSubview:self.scr];
    [self.scr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleSeg.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
    }];
    [self.view layoutIfNeeded]; // 强制刷新
    self.scr.contentSize = CGSizeMake(screenWidth * 3, self.scr.bounds.size.height);
    
    // 一定要把UITableView返回，不能只是把self.featuredView指针传给函数，在函数里赋值
    // 因为Objective-C 传参是值传递
    self.featuredView = [self setupTableView];
    self.trendingView = [self setupTableView];
    self.allArticleView = [self setupTableView];
    
    // 不要在alloc之前就设置tag，这样会让tag丢掉
    self.featuredView.tag = 101;
    self.trendingView.tag = 102;
    self.allArticleView.tag = 103;
    
    self.allArticleView.frame = CGRectMake(0, 0, screenWidth, self.scr.bounds.size.height);
    self.featuredView.frame = CGRectMake(screenWidth, 0, screenWidth, self.scr.bounds.size.height);
    self.trendingView.frame = CGRectMake(screenWidth * 2, 0, screenWidth, self.scr.bounds.size.height);
    
    [self.scr addSubview:self.allArticleView];
    [self.scr addSubview:self.featuredView];
    [self.scr addSubview:self.trendingView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(articleDidChange:) name:@"ArticleLikedDidChange" object:nil];
}
- (UITableView *)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[HomeArticelCell class] forCellReuseIdentifier:@"cell"];
    return tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 101) {
        return self.model.featuredArticles.count;
    } else if (tableView.tag == 102) {
        return self.model.trendingArticles.count;
    } else {
        return self.model.allArticles.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeArticelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (tableView.tag == 101) {
        [cell updateWithModel:self.model.featuredArticles row:indexPath.row];
    } else if (tableView.tag == 102) {
        [cell updateWithModel:self.model.trendingArticles row:indexPath.row];
    } else {
        [cell updateWithModel:self.model.allArticles row:indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 350;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)segAction:(UISegmentedControl *) seg {
    NSInteger page = seg.selectedSegmentIndex;
    [self.scr setContentOffset:CGPointMake(self.scr.bounds.size.width * page, 0)];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 因为tableView也继承于UIScrollView
    // 所以 tableView 滚动也会触发 scrollViewDidScroll:，就会导致竖直滑动tableView的时候segmentControl也会移动
    // 只处理横向翻页的 scr，忽略 tableView 的滚动
    if (scrollView != self.scr) return;
    CGFloat pageWidth = scrollView.bounds.size.width;
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat realPage = offset / pageWidth;
    NSInteger index = (NSInteger)(realPage + 0.5);
    index = MAX(0, MIN(index, 2));
    self.titleSeg.selectedSegmentIndex = index;
}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    // 如果viewDidLoad已经调用过，该页面不是第一次展示而是离开该页面在其他页面修改数据，再次回到该页面的时候不会重新复用cell
//    // 一次就不会updateWithModel使用修改后的model，所以这个时候传值就没有效果，因为viewDidLoad只加载一次
//    // 所以只能reloadData
//    // 这里通知里的reloadData没有用是因为因为 NSNotificationCenter 的通知是即时广播，不是消息队列
//    // postNotificationName 发出去的那一刻，只有当前已经 addObserver 的对象能收到
//    // 没有注册的、已经移除的、还没创建的页面，都收不到。系统不会帮你保存这条通知，等它以后出现再补发
//    // 这里在viewWillAppear:注册通知，viewWillDisappear:移除监听就是会收不到，dealloc移除
//    // ‼️所以正确应该在viewDidLoad注册，dealloc移除
//    // 我会想到在Will里操作是登录注册页键盘通知的教训，但是还是用错了
//    [self.featuredView reloadData];
//    [self.trendingView reloadData];
//    [self.allArticleView reloadData];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(articleDidChange:) name:@"ArticleLikedDidChange" object:nil];
//}
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
- (void)articleDidChange:(NSNotification *) notification {
    [self.featuredView reloadData];
    [self.trendingView reloadData];
    [self.allArticleView reloadData];
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
