//
//  RegisterVC.h
//  3GShare
//
//  Created by lifany on 2026/5/14.
//

#import <UIKit/UIKit.h>
#import "TextFieldView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol memorizeAccount <NSObject>

- (void)memorizeWithAccount:(NSString*) account;

@end
@interface RegisterVC : UIViewController
@property (nonatomic, strong) TextFieldView *accountView;
@property (nonatomic, strong) TextFieldView *cipherView;
@property (nonatomic, strong) TextFieldView *emailView;
@property (nonatomic, weak) id<memorizeAccount> delegate;
@end

NS_ASSUME_NONNULL_END
