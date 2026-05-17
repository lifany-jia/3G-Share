//
//  TextFieldView.m
//  3GShare
//
//  Created by lifany on 2026/5/14.
//

#import "TextFieldView.h"
#import <Masonry/Masonry.h>
@interface TextFieldView ()
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *placeHold;
@end
@implementation TextFieldView
- (instancetype)initWithIconName:(NSString *)iconName placeHold:(NSString *)placeHold {
    self = [super init];
    if (self) {
        self.iconName = iconName;
        self.placeHold = placeHold;
        [self setupView];
    }
    return self;
}
- (void)setupView {
    self.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor whiteColor];
    UIImage *line = [UIImage imageNamed:@"line"];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:self.iconName]];
    self.tintColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    UIImageView *lineView = [[UIImageView alloc] initWithImage:line];
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = self.placeHold;
    // view.clipsToBounds, view.layer.masksToBounds都是裁剪的意思，只不过层面不一样
    // shadowOffset（x, y）中x为正是阴影向右偏移，为负是阴影向左偏移，y为正是阴影向下偏移，为负是阴影向上偏移
    self.layer.shadowOffset = CGSizeMake(3, 3);   // 阴影偏移 (x, y)
    self.layer.shadowRadius = 4;                  // 阴影模糊半径
    self.layer.shadowOpacity = 0.3;     // 阴影透明度
    [self addSubview:icon];
    [self addSubview:lineView];
    [self addSubview:self.textField];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.height.width.mas_offset(30);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(10);
        make.top.equalTo(self).offset(8);
        make.bottom.equalTo(self).offset(-8);
        make.width.mas_offset(2);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(lineView).offset(10);
        make.right.equalTo(self);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
