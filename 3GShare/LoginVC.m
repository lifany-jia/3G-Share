//
//  LoginVC.m
//  3GShare
//
//  Created by lifany on 2026/5/13.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "HomeVC.h"
#import "SearchVC.h"
#import "ArticleVC.h"
#import "PersonVC.h"
#import "TaskVC.h"
#import "TextFieldView.h"
#import "UserInfo.h"

#import "ViewController.h"
#import "Masonry/Masonry.h"
@interface LoginVC () <memorizeAccount>
@property (nonatomic, strong) TextFieldView *accountView;
@property (nonatomic, strong) TextFieldView *cipherView;
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
    
    self.accountView = [[TextFieldView alloc] initWithIconName:@"person" placeHold:@"请输入账号"];
    [self.view addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareLogo).offset(250);
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
    
#pragma mark - button
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor whiteColor];
    loginButton.layer.cornerRadius = 8;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0]];
    loginButton.layer.borderWidth = 1.0;
    loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    loginButton.layer.shadowOffset = CGSizeMake(3, 3);   // 阴影偏移 (x, y)
    loginButton.layer.shadowRadius = 4;                  // 阴影模糊半径
    loginButton.layer.shadowOpacity = 0.3;     // 阴影透明度
    [loginButton addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [loginButton addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
    [loginButton addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchCancel];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.backgroundColor = [UIColor whiteColor];
    registerButton.layer.cornerRadius = 8;
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
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
    [registerButton addTarget:self action:@selector(registerViewPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cipherView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(80);
        make.height.mas_offset(40);
        make.width.mas_offset(100);
    }];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton);
        make.left.equalTo(loginButton.mas_right).offset(30);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
    
    UIButton *autoLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *unchecked = [UIImage systemImageNamed:@"circle"];
    UIImage *checked = [UIImage systemImageNamed:@"record.circle"];
    [autoLoginButton setImage:unchecked forState:UIControlStateNormal];
    // 这里只有当按钮处于selected的状态才会变化，所以还得添加一个点击事件来改变这个状态
    [autoLoginButton setImage:checked forState:UIControlStateSelected];
    [autoLoginButton setTitle:@"自动登录" forState:UIControlStateNormal];
    [autoLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [autoLoginButton addTarget:self action:@selector(toggleAutoLogin:) forControlEvents:UIControlEventTouchUpInside];
    autoLoginButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:autoLoginButton];
    
    [autoLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(loginButton.mas_bottom).offset(20);
            make.left.equalTo(self.accountView);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    // 注册在viewDidLoad会有问题，会导致如果从注册页返回时键盘收起 的通知还会同时触发LoginVC 的 keyboardWillHide
    // 导致 LoginVC 的 view 执行了一次 CGAffineTransformIdentity 复位，但是此时的但 LoginVC 的 view 此时不一定是偏移状态
    // 就会导致奇怪的下降或上移
    // 所以我们要在页面出现时再注册监听，同时页面消失的时候复位并移除监听
    
    // UIKeyboardWillShowNotification        // 键盘即将弹出的通知名
    // UIKeyboardWillHideNotification        // 键盘即将收起的通知名
    // UIKeyboardFrameEndUserInfoKey         // 从通知里取键盘最终frame
    // UIKeyboardAnimationDurationUserInfoKey // 从通知里取动画时长
    // 键盘弹出通知由系统完成， 我们直接使用Apple提供的常量即可
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // resignFirstResponder 让特定的 TextField 放弃第一响应者（收起键盘）
    // [self.view endEditing:YES] 让 view 下所有正在编辑的控件放弃第一响应者
    [self.view endEditing:YES];
}
- (void)toggleAutoLogin:(UIButton *)but {
    but.selected = !but.selected;
}

#pragma mark - buttonTouchAction
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

#pragma mark - keyboard
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
#pragma mark - pushVIew
- (void)registerViewPush {
    RegisterVC *registerView = [[RegisterVC alloc] init];
    registerView.delegate = self;
    [self.navigationController pushViewController:registerView animated:YES];
}
- (void)loginAction {
    NSString *name = self.accountView.textField.text;
    NSString *password = self.cipherView.textField.text;
    if (name.length == 0 || password.length == 0) {
        [self showAlertWithMessage:@"账号或密码不能为空！"];
        return ;
    }
    UserInfo *use = [UserInfo loginWithName:name password:password];
    if (!use) {
        [self showAlertWithMessage:@"账户或密码错误！"];
    } else {
        [self switchToTabBar];
    }
}
- (void)switchToTabBar {
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    
    HomeVC *home = [[HomeVC alloc] init];
    home.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"homeSelection"]];
    SearchVC *search = [[SearchVC alloc] init];
    search.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"search"] selectedImage:[UIImage imageNamed:@"searchSelection"]];
    ArticleVC *article = [[ArticleVC alloc] init];
    article.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"article"] selectedImage:[UIImage imageNamed:@"articleSelection"]];
    TaskVC *task = [[TaskVC alloc] init];
    task.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"task"] selectedImage:[UIImage imageNamed:@"taskSelection"]];
    PersonVC *person = [[PersonVC alloc] init];
    person.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"person"] selectedImage:[UIImage imageNamed:@"personSelection"]];
    tabBarVC.viewControllers = @[home, search, article, task, person];
    
    UIWindow *window = self.view.window;
    if (!window) return;
    window.rootViewController = tabBarVC;
    [window makeKeyAndVisible];
    
    // 添加过渡动画
    [UIView transitionWithView:window duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil];
}
- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)memorizeWithAccount:(NSString *)account {
    self.accountView.textField.text = account;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 移除键盘监听，之后的键盘事件不再影响这个页面
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 复位
    self.view.transform = CGAffineTransformIdentity;
    // 强制收起键盘
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
