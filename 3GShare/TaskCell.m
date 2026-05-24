//
//  TaskCell.m
//  3GShare
//
//  Created by lifany on 2026/5/21.
//

#import "TaskCell.h"
#import <Masonry/Masonry.h>
@interface TaskCell ()
@property (nonatomic, strong) UIImageView *imaV;
@property (nonatomic, strong) UILabel *label;
@end
@implementation TaskCell

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
        [self setupTaskView];
    }
    return self;
}
- (void)setupTaskView {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor whiteColor];
    back.clipsToBounds = YES;
    back.layer.cornerRadius = 10;
    [self.contentView addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.imaV = [[UIImageView alloc] init];
//    self.imaV.contentMode = UIViewContentModeScaleAspectFit;
    self.imaV.contentMode = UIViewContentModeScaleAspectFill;
    self.imaV.clipsToBounds = YES;    [back addSubview:self.imaV];
    [self.imaV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(back);
    }];
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor labelColor];
    self.label.font = [UIFont systemFontOfSize:16];
    [back addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imaV.mas_bottom).offset(10);
            make.right.left.equalTo(back).offset(10);
            make.bottom.equalTo(back).offset(-10);
    }];
}
- (void)updateWithImaName:(NSArray *)imaName label:(NSArray *)label row:(NSInteger)row{
    self.label.text = label[row];
    UIImage *ima = [UIImage imageNamed:imaName[row]];
    self.imaV.image = ima;
    if (ima) {
        CGFloat ratio = ima.size.height / ima.size.width;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat imageHeight = screenWidth * ratio;
        [self.imaV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(imageHeight);
        }];
    }
}
@end
