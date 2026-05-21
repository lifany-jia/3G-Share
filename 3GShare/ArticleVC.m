//
//  ArticleVC.m
//  3GShare
//
//  Created by lifany on 2026/5/17.
//

#import "ArticleVC.h"
#import "ArticleModel.h"
#import "HomeArticelCell.h"
@interface ArticleVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *featuredView;
@property (nonatomic, strong) UITableView *trendingView;
@property (nonatomic, strong) UITableView *allArticleView;
@property (nonatomic, strong) UIScrollView *scr;
@property (nonatomic, strong) UISegmentedControl *titleSeg;
@property (nonatomic, strong) TypeArtiModel *model;
@end

@implementation ArticleVC
- (instancetype)init {
    self = [super init];
    if (self) {
        self.model = [TypeArtiModel defaultTypeArtiModel];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    [appearance configureWithTransparentBackground]; // 透明背景
    // 设置半透明背景色（alpha < 1 就能透出下面）
    appearance.backgroundColor = [[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] colorWithAlphaComponent:0.9];
    appearance.titleTextAttributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:30],
        NSForegroundColorAttributeName:[UIColor whiteColor]
    };
     */
    self.navigationItem.title = @"文章";
//    self.navigationController.navigationBar.standardAppearance = appearance;
//    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    
    self.titleSeg = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 101, self.view.bounds.size.width, 50)];
    [self.titleSeg insertSegmentWithTitle:@"全部文章" atIndex:0 animated:YES];
    [self.titleSeg insertSegmentWithTitle:@"热门文章" atIndex:1 animated:YES];
    [self.titleSeg insertSegmentWithTitle:@"精选文章" atIndex:2 animated:YES];
    [self.view addSubview:self.titleSeg];
    [self.titleSeg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    self.titleSeg.selectedSegmentIndex = 1;
    
    CGFloat screenWidth = self.view.bounds.size.width;
    CGFloat screenHeight = self.view.bounds.size.height;
    self.scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 151, screenWidth, screenHeight - 50)];
    self.scr.pagingEnabled = YES;
    self.scr.delegate = self;
    self.scr.showsHorizontalScrollIndicator = NO;
    self.scr.contentSize = CGSizeMake(screenWidth * 3, self.scr.bounds.size.height);
    self.scr.contentOffset = CGPointMake(screenWidth, 0);
    [self.view addSubview:self.scr];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
