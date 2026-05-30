//
//  leftBubbleCell.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "leftBubbleCell.h"
#import <Masonry/Masonry.h>
@interface leftBubbleCell ()
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *bubbleLabel;
@property (nonatomic, strong) UIView *bubbleView;
@end
@implementation leftBubbleCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.avatar = [[UIImageView alloc] init];
    self.avatar.contentMode = UIViewContentModeScaleAspectFill;
    self.avatar.layer.cornerRadius = 20;
    self.avatar.clipsToBounds = YES;
    self.avatar.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(15);
            make.width.height.mas_equalTo(40);
    }];
    
    self.bubbleView = [[UIView alloc] init];
    self.bubbleView.backgroundColor = [UIColor whiteColor];
    self.bubbleView.layer.cornerRadius = 12;
    self.bubbleView.clipsToBounds = YES;
    [self.contentView addSubview:self.bubbleView];
    [self.bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatar);
            make.left.equalTo(self.avatar.mas_right).offset(8);
            make.right.lessThanOrEqualTo(self.contentView).offset(-80);
            make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    self.bubbleLabel = [[UILabel alloc] init];
    self.bubbleLabel.font = [UIFont systemFontOfSize:16];
    self.bubbleLabel.textColor = [UIColor blackColor];
    self.bubbleLabel.numberOfLines = 0;
    [self.bubbleView addSubview:self.bubbleLabel];
    [self.bubbleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bubbleView).insets(UIEdgeInsetsMake(10, 12, 10, 12));
    }];
}
- (void)updateWithModel:(ChatModel *)model {
    self.bubbleLabel.text = model.content;
    self.avatar.image = [UIImage imageNamed:model.avatar] ?: [UIImage systemImageNamed:@"person.circle.fill"];
}
@end
