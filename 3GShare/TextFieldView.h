//
//  TextFieldView.h
//  3GShare
//
//  Created by lifany on 2026/5/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFieldView : UIView
@property (nonatomic, strong) UITextField *textField;
- (instancetype) initWithIconName:(NSString *) iconName placeHold:(NSString *) placeHold;
@end

NS_ASSUME_NONNULL_END
