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
@property (nonatomic, strong) ArticleModel *model;
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
    containerView.clipsToBounds = YES;
    [self.contentView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7, 0, 7, 0));
    }];
    
    // 设置cell的背景透明，透出tableVIew的背景色，就会看起来每一个cell被分隔开
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.imaV = [[UIImageView alloc] init];
    self.imaV.contentMode = UIViewContentModeScaleAspectFit;
    self.imaV.layer.cornerRadius = 0;
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
    self.articleName.textColor = [UIColor labelColor];
    self.articleName.numberOfLines = 0;
    [containerView addSubview:self.articleName];
    [self.articleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(containerView).offset(10);
            make.left.equalTo(self.imaV.mas_right).offset(10);
        make.right.equalTo(containerView).offset(-5);
    }];
    
    self.authorName = [[UILabel alloc] init];
    self.authorName.font = [UIFont systemFontOfSize:13];
    self.authorName.textColor = [UIColor secondaryLabelColor];
    [containerView addSubview:self.authorName];
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.articleName.mas_bottom).offset(5);
            make.left.equalTo(self.articleName);
    }];
    
    self.taG = [[UILabel alloc] init];
    self.taG.font = [UIFont systemFontOfSize:13];
    self.taG.textColor = [UIColor secondaryLabelColor];
    [containerView addSubview:self.taG];
    [self.taG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorName.mas_bottom).offset(7);
            make.left.equalTo(self.articleName);
    }];
    
    self.time = [[UILabel alloc] init];
    self.time.font = [UIFont systemFontOfSize:10];
    self.time.textColor = [UIColor tertiaryLabelColor];
    [containerView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.taG.mas_bottom).offset(5);
            make.right.equalTo(containerView).offset(-15);
    }];
    
    self.likes = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likes setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateNormal] ;
    [self.likes setImage:[UIImage systemImageNamed:@"heart.fill"] forState:UIControlStateSelected];
    [self.likes addTarget:self action:@selector(likeSelected) forControlEvents:UIControlEventTouchUpInside];
    self.likes.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [containerView addSubview:self.likes];
    [self.likes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.time.mas_bottom).offset(12);
            make.left.equalTo(self.articleName);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(45);
            make.bottom.equalTo(containerView).offset(-10);
    }];
    
    self.views = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.views setImage:[UIImage systemImageNamed:@"eye"] forState:UIControlStateNormal] ;
    self.views.userInteractionEnabled = NO;
    self.views.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [containerView addSubview:self.views];
    [self.views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likes);
            make.left.equalTo(self.likes.mas_right).offset(15);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(55);
    }];
    
    self.shares = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shares setImage:[UIImage systemImageNamed:@"arrowshape.turn.up.right"] forState:UIControlStateNormal] ;
    [self.shares addTarget:self action:@selector(shareSelected) forControlEvents:UIControlEventTouchUpInside];
    self.shares.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [containerView addSubview:self.shares];
    [self.shares mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likes);
            make.left.equalTo(self.views.mas_right).offset(15);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(40);
    }];
    
}
- (void)updateWithModel:(NSArray<ArticleModel *> *) article row:(NSInteger)row{
    self.model = article[row];
    self.imaV.image = [UIImage imageNamed:self.model.articleName];
    self.articleName.text = self.model.articleName;
    self.authorName.text = self.model.authorName;
    self.taG.text = self.model.tag;
    self.time.text = self.model.time;
    // 通过model更新按钮的选择状态
    self.likes.selected = self.model.liked;
    [self.likes setTitle:[NSString stringWithFormat:@"%ld", (long)self.model.likes]
               forState:UIControlStateNormal];
    [self.likes setTitleColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.likes.titleLabel.font = [UIFont systemFontOfSize:10];
    // 不可以这样写
    //self.views.titleLabel.text = [NSString stringWithFormat:@"%ld", (long)model.articles[row].views];
    [self.views setTitle:[NSString stringWithFormat:@"%ld", (long)self.model.views] forState:UIControlStateNormal];
    [self.views setTitleColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.views.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [self.shares setTitle:[NSString stringWithFormat:@"%ld", (long)self.model.shares] forState:UIControlStateNormal];
    [self.shares setTitleColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.shares.titleLabel.font = [UIFont systemFontOfSize:10];
}
- (void)likeSelected {
    // 直接修改唯一model之后，发通知让所有该文章都修改点赞状态
    self.model.liked = !self.model.liked;
    if (self.model.liked) {
        self.model.likes++;
        [self.likes setTitle:[NSString stringWithFormat:@"%ld", self.model.likes]
                   forState:UIControlStateNormal];
    } else {
        self.model.likes--;
        [self.likes setTitle:[NSString stringWithFormat:@"%ld", self.model.likes]
                   forState:UIControlStateNormal];
    }
    self.likes.selected = self.model.liked;
    [self.likes setTitle:[NSString stringWithFormat:@"%ld", self.model.likes]
                      forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ArticleDidChange" object:self.model];
}

- (void)shareSelected {
    self.model.shares++;
    [self.shares setTitle:[NSString stringWithFormat:@"%ld", (long)self.model.shares]
                 forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ArticleDidChange" object:self.model];
}
@end
