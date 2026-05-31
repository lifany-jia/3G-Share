//
//  FollowCell.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "FollowCell.h"
#import <Masonry/Masonry.h>
@interface FollowCell ()
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIButton *followButton;
@end
@implementation FollowCell

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
        if ([reuseIdentifier isEqualToString:@"followCell"]) {
            [self setupFollowCell];
        } else if ([reuseIdentifier isEqualToString:@"dmCell"]) {
            [self setupDmCell];
        }
    }
    return self;
}
#pragma mark - setupFollowCell
- (void)setupFollowCell {
    self.avatar = [[UIImageView alloc] init];
    self.avatar.layer.cornerRadius = 10;
    self.avatar.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(20);
            make.width.height.mas_equalTo(50);
    }];
    
    self.name = [[UILabel alloc] init];
    self.name.font = [UIFont systemFontOfSize:16];
    self.name.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.avatar.mas_right).offset(20);
    }];
    
    self.followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.followButton.layer.cornerRadius = 15;
    self.followButton.layer.borderWidth = 1;
    
    [self.followButton setTitle:@"回关" forState:UIControlStateNormal];
    [self.followButton setTitleColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.followButton.layer.borderColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0].CGColor;
    self.followButton.backgroundColor = [UIColor whiteColor];
    
    [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];
    [self.followButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    self.followButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.followButton addTarget:self action:@selector(followTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
    }];
}
- (void)followTapped:(UIButton *) button {
    button.selected = !button.selected;
    if (button.selected) {
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    } else {
        button.layer.borderColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0].CGColor;
    }
    // 通知 VC 状态改变了（用 block 回调）
    if (self.followBlock) {
        self.followBlock(button.selected);
    }
    
}
- (void)updateWithFollowModel:(NSString *)model isSelectedd:(BOOL)isSelected {
    self.name.text = model;
    self.avatar.image = [UIImage imageNamed:model];
    self.followButton.selected = isSelected;
    if (isSelected) {
        self.followButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    } else {
        self.followButton.layer.borderColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0].CGColor;
    }
}
#pragma mark - setupDmCell
- (void)setupDmCell {
    self.avatar = [[UIImageView alloc] init];
    self.avatar.layer.cornerRadius = 10;
    self.avatar.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(50);
    }];
    
    self.name = [[UILabel alloc] init];
    self.name.font = [UIFont systemFontOfSize:16];
    self.name.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.avatar.mas_right).offset(20);
    }];
    
    self.content = [[UILabel alloc] init];
    self.content.font = [UIFont systemFontOfSize:15];
    self.content.textColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.contentView addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(10);
        make.left.equalTo(self.name);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    self.time = [[UILabel alloc] init];
    self.time.font = [UIFont systemFontOfSize:10];
    self.time.textColor = [UIColor secondaryLabelColor];
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name);
            make.right.equalTo(self.contentView).offset(-20);
    }];
}
- (void)updateWithModel:(NSDictionary *)model {
    self.avatar.image = [UIImage imageNamed:model[@"name"]];
    self.name.text = model[@"name"];
    self.content.text = model[@"content"];
    self.time.text = model[@"time"];
}

@end
