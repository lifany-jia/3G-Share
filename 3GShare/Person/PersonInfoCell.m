//
//  PersonInfoCell.m
//  3GShare
//
//  Created by lifany on 2026/5/27.
//

#import "PersonInfoCell.h"
#import <Masonry/Masonry.h>
@interface PersonInfoCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *name;
@end
@implementation PersonInfoCell

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
        [self setupCell];
    }
    return self;
}
- (void)setupCell {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.iconView = [[UIImageView alloc] init];
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconView.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.contentView addSubview:self.iconView];
    self.name = [[UILabel alloc] init];
    self.name.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.name];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(12);
        make.width.mas_offset(30);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.iconView.mas_right).offset(10);
    }];
    
}
- (void)updateWithIcon:(NSString *)icon name:(NSString *)name {
    self.iconView.image = [UIImage systemImageNamed:icon];
    self.name.text = name;
}
@end
