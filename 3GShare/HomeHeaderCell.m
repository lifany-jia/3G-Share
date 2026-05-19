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
        self.imas = [HomeModel defaultHomeModel].adImageName;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    NSInteger imaCount = self.imas.count + 2;
    self.scr = [[UIScrollView alloc] init];
    // 不可以这样，这个时候是0
    // self.scr.frame = self.contentView.bounds;
    self.scr.pagingEnabled = YES;
    self.scr.scrollEnabled = YES;
    self.scr.bounces = YES;
    self.scr.showsHorizontalScrollIndicator = NO;
    self.scr.delegate = self;
//    self.scr.contentSize = CGSizeMake(self.scr.bounds.size.width * imaCount, self.scr.bounds.size.height);
    [self.contentView addSubview:self.scr];
    [self.scr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
    }];
    [self.scr layoutIfNeeded];
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
        imaV.frame = CGRectMake(self.scr.bounds.size.width * i, 0, self.scr.bounds.size.width, self.scr.bounds.size.height);
        imaV.contentMode = UIViewContentModeScaleAspectFit;
        [self.scr addSubview:imaV];
    }
    self.scr.contentOffset = CGPointMake(self.scr.bounds.size.width, 0);
    
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.scr.bounds.size.height - 100, self.scr.bounds.size.width, 30)];
    self.page.numberOfPages = self.imas.count;
    self.page.currentPage = 0;
    self.page.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.page.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.contentView addSubview:self.page];
}
- (void)switchPage:(UIScrollView *)scr {
    CGFloat page = scr.contentOffset.x / self.scr.bounds.size.width;
    if (page == 0) {
        [scr setContentOffset:CGPointMake((self.imas.count - 1)* self.scr.bounds.size.width, 0) animated:NO];
        self.page.currentPage = self.imas.count - 1;
    } else if (page == self.imas.count) {
        [scr setContentOffset:CGPointMake(self.scr.bounds.size.width, 0) animated:NO];
        self.page.currentPage = 0;
    } else {
        self.page.currentPage = page - 1;
    }
}
- (void)startTime {
    if (self.timer && self.timer.isValid) {
        return ;
    }
    [self stopTime];
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf nextToPage];
    }];
}
- (void)stopTime {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)restartTime {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTime) object:nil];
    [self performSelector:@selector(startTime) withObject:nil afterDelay:2.0];
}
- (void)nextToPage {
    [self.scr setContentOffset:CGPointMake(self.scr.bounds.size.width + self.scr.contentOffset.x, 0) animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTime];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTime) object:nil];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self restartTime];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self switchPage:scrollView];
    [self restartTime];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self switchPage:scrollView];
}
- (void)updateWithModel:(HomeModel *)model {
    self.imas = model.adImageName;
}
- (void)dealloc {
    [self stopTime];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTime) object:nil];
}

@end
