//
//  tagView.m
//  3GShare
//
//  Created by lifany on 2026/5/23.
//

#import "tagView.h"
#import "tagCell.h"
#import <Masonry/Masonry.h>
@interface tagView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray<NSString *> * tags;
@property (nonatomic, strong) UICollectionView *collection;
@end
@implementation tagView

- (instancetype)initWithTitle:(NSString *)title tags:(NSArray<NSString *> *)tags {
    self = [super init];
    if (self) {
        self.tags = tags;
        [self setupHeaderViewWithTitle:title];
        [self setupCollectionView];
    }
    return self;
}
- (instancetype)initWithTags:(NSArray<NSString *> *)tags {
    self = [super init];
    if (self) {
        self.tags = tags;
        [self setupCollectionView];
    }
    return self;
}
- (void)setupHeaderViewWithTitle:(NSString *) title {
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 5;
    view.backgroundColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self addSubview:view];
    UIImageView *tagIma = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"tag.fill"]];
    tagIma.contentMode = UIViewContentModeScaleAspectFit;
    tagIma.tintColor = [UIColor whiteColor];
    [view addSubview:tagIma];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(35);
    }];
    [tagIma mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view).offset(7);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(tagIma.mas_right).offset(3);
    }];
    UIView *line = [[UIView alloc] init];
    line.layer.cornerRadius = 15;
    line.backgroundColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view);
            make.left.equalTo(view).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.mas_equalTo(3);
    }];
}
- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    // 让 Cell 根据内部约束自动计算宽度
    layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    // UICollectionView 没有 init 方法
    // 必须用 initWithFrame:collectionViewLayout: 初始化
    // CGRectZero = CGRectMake(0, 0, 0, 0)

    // 因为后面会用 Masonry 设置约束
    // frame 会被约束覆盖，所以传 CGRectZero 占位就够了
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collection.backgroundColor = [UIColor clearColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    // 允许按钮多选
    self.collection.allowsMultipleSelection = YES;
    [self.collection registerClass:[tagCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(46); // header 下面
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self);
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tags.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    tagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.clipsToBounds = NO;
    cell.label.text = self.tags[indexPath.item];
    return cell;
}

@end
