//
//  LoginVC.m
//  3GShare
//
//  Created by lifany on 2026/5/13.
//

#import "LoginVC.h"
#import "Masonry/Masonry.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBackgroud"]];
    background.frame = self.view.bounds;
    [self.view addSubview:background];
    
    UIImageView *shareLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:shareLogo];
    [shareLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.height.width.mas_equalTo(175);
    }];
    
    // 这里其实是没有用的，因为mas约束不会立即改变shareLoge的frame和bounds
    // 此时读取的bounds还是0
    // [self.view layoutIfNeeded]; 所以应该在父视图强制系统立即处理布局
    // 并且要shareLogo.clipsToBounds = YES;
    // shareLogo.contentMode = UIViewContentModeScaleAspectFill;
    // 或者直接用数字，我们这里成功的原因是因为我后面改成直接传入一个圆形图片！！聪明
    shareLogo.layer.cornerRadius = shareLogo.bounds.size.width / 2;

    
    UIImageView *shareLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shareLabel"]];
    shareLabel.frame = CGRectMake(-188, 262.5, 750, 75);
    [self.view addSubview:shareLabel];
    
    UIImage *line = [UIImage imageNamed:@"line"];
    
#pragma mark - accountTextField
    UIView *accountView = [[UIView alloc] init];
    accountView.layer.cornerRadius = 10;
    accountView.backgroundColor = [UIColor whiteColor];
    UIImageView *accIcon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"person"]];
    UIImageView *lineAccount = [[UIImageView alloc] initWithImage:line];
    UITextField *accoutField = [[UITextField alloc] init];
    accoutField.placeholder = @"请输入账号";
    [self.view addSubview:accountView];
    [accountView addSubview:accIcon];
    [accountView addSubview:lineAccount];
    [accountView addSubview:accoutField];
    
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareLogo).offset(250);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(50);
        make.width.mas_offset(300);
    }];
    [accIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(accountView);
        make.left.equalTo(accountView).offset(10);
        make.width.height.mas_offset(30);
    }];
    [lineAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accIcon.mas_right).offset(10);
        make.top.equalTo(accountView).offset(8);
        make.bottom.equalTo(accountView).offset(-8);
        make.width.mas_offset(2);
    }];
    [accoutField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(accountView);
        make.left.equalTo(lineAccount).offset(10);
        make.right.equalTo(accountView);
    }];
    
#pragma mark - cipherTextField
    UIView *cipherView = [[UIView alloc] init];
    cipherView.layer.cornerRadius = 10;
    cipherView.backgroundColor = [UIColor whiteColor];
    UIImageView *cipherIcon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"lock"]];
    UIImageView *lineCipher = [[UIImageView alloc] initWithImage:line];
    UITextField *cipherField = [[UITextField alloc] init];
    cipherField.placeholder = @"请输入密码";
    [self.view addSubview:cipherView];
    [cipherView addSubview:cipherIcon];
    [cipherView addSubview:lineCipher];
    [cipherView addSubview:cipherField];
    [cipherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(accountView.mas_bottom).offset(15);
        make.height.mas_offset(50);
        make.width.mas_offset(300);
    }];
    [cipherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cipherView);
        make.left.equalTo(cipherView).offset(10);
        make.height.width.mas_offset(30);
    }];
    [lineCipher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cipherIcon.mas_right).offset(10);
        make.top.equalTo(cipherView).offset(8);
        make.bottom.equalTo(cipherView).offset(-8);
        make.width.mas_offset(2);
    }];
    [cipherField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cipherView);
        make.left.equalTo(lineCipher).offset(10);
        make.right.equalTo(cipherView);
    }];
    
#pragma mark - button
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.backgroundColor = [UIColor whiteColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeClose];
    registerButton.backgroundColor = [UIColor whiteColor];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cipherView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(200);
        make.height.mas_offset(40);
        make.width.mas_offset(100);
    }];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton);
        make.left.equalTo(loginButton.mas_right).offset(10);
        make.height.mas_offset(40);
        make.width.mas_offset(100);
    }];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // resignFirstResponder 让特定的 TextField 放弃第一响应者（收起键盘）
    // [self.view endEditing:YES] 让 view 下所有正在编辑的控件放弃第一响应者
    [self.view endEditing:YES];
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
