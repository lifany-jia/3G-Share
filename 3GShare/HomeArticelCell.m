//
//  HomeArticelCell.m
//  3GShare
//
//  Created by lifany on 2026/5/18.
//

#import "HomeArticelCell.h"
#import <Masonry/Masonry.h>
@interface HomeArticelCell ()
@property (nonatomic, strong) UIImageView *imaV;
@property (nonatomic, strong) UILabel *authorName;
@property (nonatomic, strong) UILabel *articleName;
@property (nonatomic, strong) UILabel *taG;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIButton *likes;
@property (nonatomic, strong) UIButton *views;
@property (nonatomic, strong) UIButton *shares;
@end
@implementation HomeArticelCell

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
    // 让所有控件添加在这张白色卡片上
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 18;
    containerView.clipsToBounds = YES;
    [self.contentView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    // 设置cell的背景透明，透出tableVIew的背景色，就会看起来每一个cell被分隔开
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.imaV = [[UIImageView alloc] init];
    self.imaV.contentMode = UIViewContentModeScaleAspectFit;
    self.imaV.layer.cornerRadius = 18;
    self.imaV.clipsToBounds = YES;
    [containerView addSubview:self.imaV];
    [self.imaV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(containerView);
            make.bottom.equalTo(containerView);
            make.left.equalTo(containerView);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(150);
    }];
    
    self.articleName = [[UILabel alloc] init];
    self.articleName.font = [UIFont systemFontOfSize:18];
    self.articleName.numberOfLines = 0;
    [containerView addSubview:self.articleName];
    [self.articleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(containerView).offset(10);
            make.left.equalTo(self.imaV.mas_right).offset(10);
        make.right.equalTo(containerView).offset(-5);
    }];
    
    self.authorName = [[UILabel alloc] init];
    self.authorName.font = [UIFont systemFontOfSize:13];
    [containerView addSubview:self.authorName];
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.articleName.mas_bottom).offset(7);
            make.left.equalTo(self.articleName);
    }];
    
    self.taG = [[UILabel alloc] init];
    self.taG.font = [UIFont systemFontOfSize:13];
    [containerView addSubview:self.taG];
    [self.taG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorName.mas_bottom).offset(7);
            make.left.equalTo(self.articleName);
    }];
    
    self.time = [[UILabel alloc] init];
    self.time.font = [UIFont systemFontOfSize:10];
    [containerView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.taG.mas_bottom).offset(7);
            make.right.equalTo(containerView).offset(-15);
    }];
    
    self.likes = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likes setImage:[UIImage systemImageNamed:@"heart.fill"] forState:UIControlStateNormal] ;
    self.likes.tintColor = [UIColor blueColor];
    [containerView addSubview:self.likes];
    [self.likes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.time.mas_bottom).offset(10);
            make.left.equalTo(self.articleName);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(20);
            make.bottom.equalTo(containerView).offset(-10);
    }];
    
    self.views = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.views setImage:[UIImage systemImageNamed:@"eye"] forState:UIControlStateNormal] ;
    self.views.tintColor = [UIColor blueColor];
    [containerView addSubview:self.views];
    [self.views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likes);
            make.left.equalTo(self.likes.mas_right).offset(30);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(20);
    }];
    
    self.shares = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shares setImage:[UIImage systemImageNamed:@"arrowshape.turn.up.right"] forState:UIControlStateNormal] ;
    self.shares.tintColor = [UIColor blueColor];
    [containerView addSubview:self.shares];
    [self.shares mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likes);
            make.left.equalTo(self.views.mas_right).offset(30);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(20);
    }];
    
}
- (void)updateWithModel:(HomeModel *)model row:(NSInteger)row {
    self.imaV.image = [UIImage imageNamed:model.articles[row].articleName];
    self.articleName.text = model.articles[row].articleName;
    self.authorName.text = model.articles[row].authorName;
    self.taG.text = model.articles[row].tag;
    self.time.text = model.articles[row].time;
    [self.likes setTitle:[NSString stringWithFormat:@"%ld", (long)model.articles[row].likes]
               forState:UIControlStateNormal];
    // 不可以这样写
    //self.views.titleLabel.text = [NSString stringWithFormat:@"%ld", (long)model.articles[row].views];
    [self.views setTitle:[NSString stringWithFormat:@"%ld", (long)model.articles[row].views] forState:UIControlStateNormal];
    [self.shares setTitle:[NSString stringWithFormat:@"%ld", (long)model.articles[row].shares] forState:UIControlStateNormal];
}
@end
