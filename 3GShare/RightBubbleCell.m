//
//  RightBubbleCell.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "RightBubbleCell.h"
#import <Masonry/Masonry.h>
@interface RightBubbleCell ()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *bubbleLabel;
@property (nonatomic, strong) UIView *bubbleView;
@end
@implementation RightBubbleCell

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
        self.backgroundColor = [UIColor clearColor];
        // 选中样式为无
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.avatarView = [[UIImageView alloc] init];
    self.avatarView.layer.cornerRadius = 20;
    self.avatarView.clipsToBounds = YES;
    self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-15);
            make.width.height.mas_equalTo(40);
    }];
    
    self.bubbleView = [[UIView alloc] init];
    self.bubbleView.backgroundColor = [UIColor colorWithRed:53.0/255.0
                                                      green:143.0/255.0
                                                       blue:203.0/255.0
                                                      alpha:1.0];
    self.bubbleView.layer.cornerRadius = 12;
    self.bubbleView.clipsToBounds = YES;
    [self.contentView addSubview:self.bubbleView];
    [self.bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarView);
            make.right.equalTo(self.avatarView.mas_left).offset(-8);
        // 撑起 Cell 高度
            make.bottom.equalTo(self.contentView).offset(-10);
            // 最大宽度限制
            make.left.greaterThanOrEqualTo(self.contentView).offset(80);
    }];
    self.bubbleLabel = [[UILabel alloc] init];
    self.bubbleLabel.font = [UIFont systemFontOfSize:16];
    self.bubbleLabel.textColor = [UIColor whiteColor];
    self.bubbleLabel.numberOfLines = 0;
    [self.bubbleView addSubview:self.bubbleLabel];
    [self.bubbleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bubbleView).insets(UIEdgeInsetsMake(10, 12, 10, 12));
    }];
}
- (void)updateWithModel:(ChatModel *)model {
    self.bubbleLabel.text = model.content;
    self.avatarView.image = [UIImage imageNamed:model.avatar] ?: [UIImage systemImageNamed:@"person.circle.fill"];
}
@end
