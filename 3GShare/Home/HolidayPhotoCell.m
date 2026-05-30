//
//  HolidayPhotoCell.m
//  3GShare
//
//  Created by lifany on 2026/5/21.
//

#import "HolidayPhotoCell.h"
#import <Masonry/Masonry.h>
@interface HolidayPhotoCell ()
@property (nonatomic, strong) UIImageView *imaV;
@end
@implementation HolidayPhotoCell

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
        [self setupPhoto];
    }
    return self;
}
- (void)setupPhoto {
    self.imaV = [[UIImageView alloc] init];
    self.imaV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imaV];
    [self.imaV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.contentView);
           make.bottom.equalTo(self.contentView);
           make.left.equalTo(self.contentView);
           make.right.equalTo(self.contentView); //  宽度铺满让图片横向填满屏幕
       }];
}
- (void)updateWithModel:(NSArray *)model index:(NSInteger)index {
    UIImage *image = [UIImage imageNamed:model[index]];
    self.imaV.image = image;
    
     // 根据图片真实比例设置高度约束
    // 让 Cell 高度跟着图片比例走（自适应高度）
    if (image) {
        CGFloat ratio = image.size.height / image.size.width;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat imageHeight = screenWidth * ratio;
        
        // 更新高度约束
        [self.imaV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(imageHeight);
        }];
    }
}
@end
