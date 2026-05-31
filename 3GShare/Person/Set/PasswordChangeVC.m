//
//  PasswordChangeVC.m
//  3GShare
//
//  Created by lifany on 2026/5/27.
//

#import "PasswordChangeVC.h"
#import <Masonry/Masonry.h>
@interface PasswordChangeVC ()
@property (nonatomic, strong) UITextField *oldPasswordText;
@property (nonatomic, strong) UITextField *freshPasswordText;
@property (nonatomic, strong) UITextField *confirmPasswordText;

@end

@implementation PasswordChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"密码修改";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = save;
    
    UIView *oldPassword = [[UIView alloc] init];
    oldPassword.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oldPassword];
    UILabel *oldPasswordLabel = [[UILabel alloc] init];
    oldPasswordLabel.text = @"旧密码";
    [oldPassword addSubview:oldPasswordLabel];
    self.oldPasswordText = [[UITextField alloc] init];
    self.oldPasswordText.placeholder = @"6-20英文或数字结合";
    self.oldPasswordText.secureTextEntry = YES;
    [oldPassword addSubview:self.oldPasswordText];
    [oldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(60);
    }];
    [oldPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(oldPassword);
            make.left.equalTo(oldPassword).offset(20);
    }];
    [self.oldPasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(oldPassword);
            make.left.equalTo(oldPassword).offset(120);
    }];
    
    UIView *freshPassword = [[UIView alloc] init];
    freshPassword.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:freshPassword];
    UILabel *freshPasswordLabel = [[UILabel alloc] init];
    freshPasswordLabel.text = @"新密码";
    [freshPassword addSubview:freshPasswordLabel];
    self.freshPasswordText = [[UITextField alloc] init];
    self.freshPasswordText.placeholder = @"6-20英文或数字结合";
    self.freshPasswordText.secureTextEntry = YES;
    [freshPassword addSubview:self.freshPasswordText];
    [freshPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPassword.mas_bottom).offset(3);            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(60);
    }];
    [freshPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(freshPassword);
            make.left.equalTo(freshPassword).offset(20);
    }];
    [self.freshPasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(freshPassword);
            make.left.equalTo(freshPassword).offset(120);
    }];
    
    UIView *confirmPassword = [[UIView alloc] init];
    confirmPassword.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:confirmPassword];
    UILabel *confirmPasswordLabel = [[UILabel alloc] init];
    confirmPasswordLabel.text = @"确认密码";
    [confirmPassword addSubview:confirmPasswordLabel];
    self.confirmPasswordText = [[UITextField alloc] init];
    self.confirmPasswordText.placeholder = @"请再次确认输入密码";
    self.confirmPasswordText.secureTextEntry = YES;
    [confirmPassword addSubview:self.confirmPasswordText];
    [confirmPassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(freshPassword.mas_bottom).offset(3);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(60);
    }];
    [confirmPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(confirmPassword);
            make.left.equalTo(confirmPassword).offset(20);
    }];
    [self.confirmPasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(confirmPassword);
            make.left.equalTo(confirmPassword).offset(120);
    }];
}
- (void)saveAction {
    if (self.oldPasswordText.text.length == 0 || self.confirmPasswordText.text.length == 0 || self.freshPasswordText.text.length == 0) {
        [self showAlert:@"不能为空" completion:nil];
    } else if (![self.confirmPasswordText.text isEqualToString:self.freshPasswordText.text]) {
        [self showAlert:@"新密码和确认密码不一致" completion:nil];
    } else {
        [self showAlert:@"密码修改成功！"completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}
- (void)showAlert:(NSString *) message completion:(void (^)(void))completion{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
