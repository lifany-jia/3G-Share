//
//  RegisterVC.m
//  3GShare
//
//  Created by lifany on 2026/5/14.
//

#import "RegisterVC.h"
#import "TextFieldView.h"
#import "UserInfo.h"
#import <Masonry/Masonry.h>
@interface RegisterVC ()

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBackgroud"]];
    backgroundView.frame = self.view.bounds;
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundView];
    
    UIImageView *shareLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:shareLogo];
    [shareLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.height.width.mas_equalTo(175);
    }];
    
    UIImageView *shareLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shareLabel"]];
    shareLabel.frame = CGRectMake(-188, 262.5, 750, 75);
    [self.view addSubview:shareLabel];
    
    self.emailView = [[TextFieldView alloc] initWithIconName:@"envelope" placeHold:@"请输入邮箱地址"];
    self.emailView.textField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.emailView];
    [self.emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareLogo).offset(250);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(50);
        make.width.mas_offset(300);
    }];
    
    self.accountView = [[TextFieldView alloc] initWithIconName:@"person" placeHold:@"请输入账号"];
    self.accountView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailView.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(50);
        make.width.mas_offset(300);
    }];
    
    self.cipherView = [[TextFieldView alloc] initWithIconName:@"lock" placeHold:@"请输入密码"];
    self.cipherView.textField.secureTextEntry = YES;
    [self.view addSubview:self.cipherView];
    [self.cipherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.accountView.mas_bottom).offset(15);
        make.height.mas_offset(50);
        make.width.mas_offset(300);
    }];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.backgroundColor = [UIColor whiteColor];
    registerButton.layer.cornerRadius = 8;
    [registerButton setTitle:@"确认注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [registerButton setBackgroundColor:[UIColor systemBlueColor]];
    registerButton.layer.borderWidth = 1.0;
    registerButton.layer.borderColor = [UIColor whiteColor].CGColor;
    registerButton.layer.shadowOffset = CGSizeMake(3, 3);   // 阴影偏移 (x, y)
    registerButton.layer.shadowRadius = 4;                  // 阴影模糊半径
    registerButton.layer.shadowOpacity = 0.3;     // 阴影透明度
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setBackgroundColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0]];
    [registerButton addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
    // 无论手指怎么抬起（正常点、滑出、被打断），都能把按钮恢复原状，否则按钮会一直卡在「缩小 + 变亮」的状态
    // 在按钮内按下 → 在按钮内抬起
    [registerButton addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    // 在按钮内按下 → 滑出按钮再抬起 ，反悔了
    [registerButton addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
    // 中断（来电话、系统弹窗等）
    [registerButton addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchCancel];
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cipherView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(130);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)buttonTouchDown:(UIButton *)but {
    // 触觉反馈，手机震动
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    [generator impactOccurred];
    [UIView animateWithDuration:0.08 animations:^{
            but.backgroundColor = [UIColor colorWithRed:80.0 / 255.0 green:179.0 / 255.0 blue:249.0 / 225.0 alpha:1.0];
            // 缩放0.97，模拟按钮按下
        // CGAffineTransform 是一个矩阵变换，用来描述视图的变形状态（缩放、旋转、平移）
            but.transform = CGAffineTransformMakeScale(0.97, 0.97);
            but.layer.shadowOpacity = 0.15;
            but.layer.shadowOffset = CGSizeMake(1, 1);
    }];
}
- (void)buttonTouchUp:(UIButton *)but {
    [UIView animateWithDuration:0.08 animations:^{
            but.backgroundColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
        // CGAffineTransformIdentity 是恒等变换，代表「原始状态，没有任何变形」
            but.transform = CGAffineTransformIdentity;
            but.layer.shadowOffset = CGSizeMake(3, 3);
            but.layer.shadowOpacity = 0.3;
    }];
}
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        // 修改frame 会受 Auto Layout 约束控制，改了之后，系统下一次布局又会把它改回去，冲突！
        // transform 是在 frame 基础上的"额外变换"，不影响约束，动画结束后系统也不会重置它
            self.view.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight / 2);
    }];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformIdentity;
    }];
}
- (void)registerAction {
    // 从输入框里取出用户名和邮箱，并去掉前后的空格、换行
    // [NSCharacterSet whitespaceAndNewlineCharacterSet]表示字符集和，里面包括空格，tab，\n，\r
    NSString *name = [self.accountView.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailView.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = self.cipherView.textField.text;
    if (name.length == 0 || email.length == 0 || password.length == 0) {
        [self showAlertWithMessage:@"邮箱、账号或密码不能为空！"];
        return;
    }
    if (name.length < 3 || name.length > 16) {
        [self showAlertWithMessage:@"账号长度需为3-16位！"];
        return;
    }
    if (![self isValidEmail:email]) {
        [self showAlertWithMessage:@"请输入正确的邮箱格式！"];
        return;
    }
    if (password.length < 6 || password.length > 20) {
        [self showAlertWithMessage:@"密码长度需为6-20位！"];
        return;
    }
    if ([UserInfo registerWithName:name password:password email:email]) {
        // 安全检查，不然协议其实没有实现对应的方法会直接奔溃
        if ([self.delegate respondsToSelector:@selector(memorizeWithAccount:)]) {
            [self.delegate memorizeWithAccount:name];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showAlertWithMessage:@"账户已存在！"];
    }
}
- (BOOL)isValidEmail:(NSString *)email {
    // 正则表达式，描述邮箱格式
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}";
    // 创建一个判断器，判断对象本身是否符合 emailRegex 这个正则表达式
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    // 把 email 交给 emailPredicate 这个判断器作为 SELF，让它判断是否符合规则
    return [emailPredicate evaluateWithObject:email];
}
- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
