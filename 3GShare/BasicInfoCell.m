//
//  BasicInfoCell.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "BasicInfoCell.h"
#import <Masonry/Masonry.h>
@interface BasicInfoCell ()
@property (nonatomic, strong) UIImageView *avator;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIButton *femaleButton;
@property (nonatomic, strong) UIButton *maleButton;
@end
@implementation BasicInfoCell

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
        if ([reuseIdentifier isEqualToString:@"avatarCell"]) {
            [self setupAvator];
        } else if ([reuseIdentifier isEqualToString:@"genderCell"]) {
            [self setupGender];
        } else {
            [self setupInfo];
        }
    }
    return self;
}
- (void)setupAvator {
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(35);
    }];
    
    self.avator = [[UIImageView alloc] init];
    self.avator.contentMode = UIViewContentModeScaleAspectFit;
    self.avator.layer.cornerRadius = 10;
    self.avator.clipsToBounds = YES;
    [self.contentView addSubview:self.avator];
    [self.avator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.label.mas_right).offset(30);
        make.width.height.mas_equalTo(80);
    }];
}
- (void)updateWithTitle:(NSString *)title avatar:(NSString *)avatar {
    self.label.text = title;
    UIImage *ima = [UIImage imageNamed:avatar];
    self.avator.image = ima;
}
- (void)setupInfo {
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(35);
    }];
    
    self.content = [[UILabel alloc] init];
    self.content.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.label.mas_right).offset(30);
    }];
}
- (void)updateWithTitle:(NSString *)title content:(NSString *)content {
    self.label.text = title;
    self.content.text = content;
}
- (void)setupGender {
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(35);
    }];
    
    self.femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.femaleButton setImage:[UIImage systemImageNamed:@"figure.stand.dress"] forState:UIControlStateNormal];
    [self.femaleButton setTitle:@"女" forState:UIControlStateNormal];
    [self.femaleButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    [self.femaleButton addTarget:self action:@selector(femaleAction) forControlEvents:UIControlEventTouchUpInside];
    self.femaleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.femaleButton];
    [self.femaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.label.mas_right).offset(30);
    }];
    
    self.maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.maleButton setImage:[UIImage systemImageNamed:@"figure.stand"] forState:UIControlStateNormal];
    [self.maleButton setTitle:@"男" forState:UIControlStateNormal];
    [self.maleButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    [self.maleButton addTarget:self action:@selector(maleAction) forControlEvents:UIControlEventTouchUpInside];
    self.maleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.maleButton];
    [self.maleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.femaleButton.mas_right).offset(20);
    }];
}
- (void)femaleAction {
    self.femaleButton.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    self.maleButton.tintColor = [UIColor lightGrayColor];
}
- (void)maleAction {
    self.maleButton.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    self.femaleButton.tintColor = [UIColor lightGrayColor];
}
- (void)updateWithTitle:(NSString *)title isFemale:(BOOL)isFemale{
    self.label.text = title;
    if (isFemale) {
        self.femaleButton.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
        self.maleButton.tintColor = [UIColor lightGrayColor];
    } else {
        self.maleButton.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
        self.femaleButton.tintColor = [UIColor lightGrayColor];
    }
}
@end
