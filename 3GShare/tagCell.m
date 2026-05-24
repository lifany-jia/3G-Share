//
//  tagCell.m
//  3GShare
//
//  Created by lifany on 2026/5/23.
//

#import "tagCell.h"
#import <Masonry/Masonry.h>

@implementation tagCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.contentView.layer.shadowOffset = CGSizeMake(2, 2);
        self.contentView.layer.shadowRadius = 2;
        self.contentView.layer.shadowOpacity = 0.1;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(8, 12, 8, 12)) ;
        }];
    }
    return self;
}
// 选中状态切换
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.contentView.backgroundColor = selected ? [UIColor colorWithRed:53.0/255.0 \
                                                                  green:143.0/255.0 \
                                                                   blue:203.0/255.0 \
                                                                  alpha:1.0] : [UIColor whiteColor];
    self.label.textColor = selected ? [UIColor whiteColor] : [UIColor blackColor];
    self.contentView.layer.borderColor = selected ? [UIColor colorWithRed:53.0/255.0 \
                                                                    green:143.0/255.0 \
                                                                     blue:203.0/255.0 \
                                                                    alpha:1.0].CGColor : [UIColor lightGrayColor].CGColor;
}
@end
