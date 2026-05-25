//
//  HomeHeaderCell.m
//  3GShare
//
//  Created by lifany on 2026/5/18.
//

#import "HomeHeaderCell.h"
@interface HomeHeaderCell () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scr;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSArray *imas;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL hasSetup;  // 防止每次layoutSubviews都重建
// 滚动离开屏幕再回来都可能自动调用layoutSubviews，如果没有bool值，每次调用这个函数都会重复创建图片导致内存爆炸
@end
@implementation HomeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.scr = [[UIScrollView alloc] init];
    // 不可以这样，这个时候是0
    // self.scr.frame = self.contentView.bounds;
    self.scr.pagingEnabled = YES;
    self.scr.scrollEnabled = YES;
    self.scr.bounces = YES;
    self.scr.showsHorizontalScrollIndicator = NO;
    self.scr.delegate = self;
    [self.contentView addSubview:self.scr];
    [self.scr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
    }];
    
    self.page = [[UIPageControl alloc] init];
    self.page.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.page.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.contentView addSubview:self.page];
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

// 无法在initWithStyle传入model，因为我们不会主动调用这个函数，我们只能从复用池中取出
// 所以只能在init的时候创建控件，后续再进行赋值
// 在init和configWithModel我们都不做依赖 bounds / frame‼️因为约束在layoutSubviews才会生效，这个时候 bounds 才有值
- (void)configWithModel:(NSArray *)imas {
    self.imas = imas;
    self.page.numberOfPages = self.imas.count;
    self.hasSetup = NO;  // 标记需要重新创建
    [self layoutIfNeeded];   // 触发 layoutSubviews 告诉系统：我需要重新布局
}
// 约束会在此函数开始计算，这个时候self.contentView.bounds才会有值
- (void)layoutSubviews {
    [super layoutSubviews];
    // bounds 有值 + 有数据 + 还没创建 → 创建图片
    if (!self.hasSetup && self.scr.frame.size.width > 0 && self.imas.count > 0) {
        [self creatImages];
        self.hasSetup = YES;
    }
}
- (void)prepareForReuse {
       [super prepareForReuse];
       self.hasSetup = NO;
       self.imas = nil;
       [self stopTime];
       for (UIView *subView in self.scr.subviews) {
           [subView removeFromSuperview];
       }
   }

- (void)creatImages {
    CGFloat scrWidth = self.scr.bounds.size.width;
    CGFloat scrHeight = self.scr.bounds.size.height;
    NSInteger imaCount = self.imas.count + 2;
    for (UIView *subView in self.scr.subviews) {
        [subView removeFromSuperview]; // 清除旧的视图
    }
    // 创建图片
    for (int i = 0; i < imaCount; i++) {
        UIImage *ima;
        if (i == 0) {
            ima = [UIImage imageNamed:self.imas[self.imas.count - 1]];
        } else if (i == imaCount - 1) {
            ima = [UIImage imageNamed:self.imas[0]];
        } else {
            ima = [UIImage imageNamed:self.imas[i - 1]];
        }
        UIImageView *imaV = [[UIImageView alloc] initWithImage:ima];
        imaV.frame = CGRectMake(scrWidth * i, 0, scrWidth, scrHeight);
        imaV.contentMode = UIViewContentModeScaleAspectFill;
        [self.scr addSubview:imaV];
    }
    self.page.currentPage = 0;
    self.scr.contentOffset = CGPointMake(scrWidth, 0);
    self.scr.contentSize = CGSizeMake(scrWidth * imaCount, scrHeight);
}
#pragma mark - AutoScrollAndNSTimer
// 遇到哑页移动contentOffset到正确的照片
- (void)switchPage:(UIScrollView *)scr {
    CGFloat page = scr.contentOffset.x / self.scr.bounds.size.width;
    if (page == 0) {
        [scr setContentOffset:CGPointMake((self.imas.count - 1)* self.scr.bounds.size.width, 0) animated:NO];
        self.page.currentPage = self.imas.count - 1;
    } else if (page == self.imas.count + 1) {
        [scr setContentOffset:CGPointMake(self.scr.bounds.size.width, 0) animated:NO];
        self.page.currentPage = 0;
    } else {
        self.page.currentPage = page - 1;
    }
}
// 在cell即将使用时开启定时器
- (void)startTime {
    if (self.timer && self.timer.isValid) {
        return ;
    }
    [self stopTime];
    __weak typeof(self) weakSelf = self;
    // 使用 NSRunLoopCommonModes，避免 tableView 滑动时 RunLoop 切到 UITrackingRunLoopMode 导致定时器停摆
    self.timer = [NSTimer timerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf nextToPage];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
// 在cell即将进入复用池时结束定时器
- (void)stopTime {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
// 用户停止拖动时重新打开定时器，执行startTime
- (void)restartTime {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTime) object:nil];
    [self performSelector:@selector(startTime) withObject:nil afterDelay:2.0];
}
// 定时器执行的方法，移动到下一页
- (void)nextToPage {
    [self.scr setContentOffset:CGPointMake(self.scr.bounds.size.width + self.scr.contentOffset.x, 0) animated:YES];
}
// 用户即将拖动的时候停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTime];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTime) object:nil];
}
// 用户结束拖动的时候重启计时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self restartTime];
    }
}
// 拖动如果会减速，在减速的时候重启计时器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self switchPage:scrollView];
    [self restartTime];
}
// 自动动画的时候添加哑页转换
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self switchPage:scrollView];
}

- (void)dealloc {
    [self stopTime];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTime) object:nil];
}

@end
