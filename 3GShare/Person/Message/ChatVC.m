//
//  ChatVC.m
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import "ChatVC.h"
#import "leftBubbleCell.h"
#import "RightBubbleCell.h"
#import <Masonry/Masonry.h>
@interface ChatVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIView *inputBar;
@property (nonatomic, strong) NSMutableArray<ChatModel *> *message;
@property (nonatomic, strong) MASConstraint *inputBarBottom;
@property (nonatomic, strong) NSString *nameOther;
@end

@implementation ChatVC
// nonull是指明确规定不可以传入nil，nullabel是指可以传入nil
- (instancetype)initWithTitle:(NSString *)title model:(nonnull NSMutableArray<ChatModel *> *)model{
    self = [super init];
    if (self) {
        self.nameOther = title;
        // 防止传入null
        self.message = model ?: [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.navigationItem.title = self.nameOther;
    
//    self.isSelf = YES;
    [self setupInputBar];
    [self setupTableView];
}
- (void)setupTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 拖动的时候会收起键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 添加点击手势使得点击聊天空白处也可以收起键盘
    // 使用touchesBegan:withEvent没有用是因为tableView覆盖在聊天区域之上，触摸会先被tableView接收
    // touchesBegan 对普通空白 UIView 有用，但对 UITableView、UICollectionView、按钮、cell 这类控件区域通常不可靠
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.tableView addGestureRecognizer:tap];
    self.tableView.estimatedRowHeight = 60;
    [self.tableView registerClass:[leftBubbleCell class] forCellReuseIdentifier:@"leftCell"];
    [self.tableView registerClass:[RightBubbleCell class] forCellReuseIdentifier:@"rightCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.inputBar.mas_top);
    }];
}
- (void)setupInputBar {
    self.inputBar = [[UIView alloc] init];
    self.inputBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.inputBar];
    [self.inputBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(60);
        // 保存约束，键盘弹起的时候修改
            self.inputBarBottom = make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    self.inputField = [[UITextField alloc] init];
    self.inputField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.inputField.layer.cornerRadius = 20;
    // 文本输入框的左侧添加一个自定义视图
    self.inputField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 0)];
    self.inputField.leftViewMode = UITextFieldViewModeAlways;
    self.inputField.delegate = self;
    self.inputField.returnKeyType = UIReturnKeySend;
    [self.inputBar addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.inputBar);
            make.left.equalTo(self.inputBar).offset(12);
            make.right.equalTo(self.inputBar).offset(-70);
            make.height.mas_equalTo(36);
    }];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendButton.backgroundColor = [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    self.sendButton.layer.cornerRadius = 15;
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.sendButton.backgroundColor =  [UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    self.sendButton.layer.cornerRadius = 15;
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.inputBar addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.inputBar);
            make.right.equalTo(self.inputBar).offset(-12);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(30);
    }];
}
- (void)sendMessage {
    NSString *text = self.inputField.text;
    if (text.length == 0) {
        return;
    }
    MessageType type = arc4random_uniform(2) == 0 ? MessageTypeSelf : MessageTypeOther;
//    MessageType type = _isSelf ? MessageTypeSelf : MessageTypeOther;
//    self.isSelf = !self.isSelf;
    NSString *avatar = type == MessageTypeSelf ? @"avatar" : self.nameOther;
    ChatModel *model = [ChatModel modelWithContent:text type:type avatar:avatar];
    [self.message addObject:model];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.message.count - 1 inSection:0];
    // 插入新的一行，不用reloadDate，因为这个会全部重建，让tableView闪一下
    // P1:插入哪些行 P2:新消息在数组中的位置
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    // P1：滚到哪一行 P2:这一行显示在哪里
    // 注意这里的position是相对于tableView的，由于我给tableView添加了约束和inputBar绑在一起
    // 所以在键盘弹起的时候inputBar上移的同时也上移了tableView的buttom
    // 所以每次有新消息滚动的时候永远都会在键盘上面，不会在整个屏幕的底部
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    self.inputField.text = @"";
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendMessage];
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏分栏控制器
    self.tabBarController.tabBar.hidden = YES;
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view endEditing:YES];
    ChatModel *last = [self.message lastObject];
     if (self.modifyLastMessage && last.content.length > 0) {
         self.modifyLastMessage(last.content);
     }
}
- (void)keyboardWillChange:(NSNotification *) notifation {
    CGRect endFrame = [notifation.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notifation.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    // 键盘高度
    CGFloat keyboardHeight = screenHeight - endFrame.origin.y;
    
    // 输入栏滚动
    // 防止键盘收起时不偏移，键盘收起时键盘坐标会大于屏幕高度
    self.inputBarBottom.mas_equalTo(-MAX(keyboardHeight - self.view.safeAreaInsets.bottom, 0));
    // 聊天信息同时滚动
    [UIView animateWithDuration:duration animations:^{
            [self.view layoutIfNeeded];
            if (self.message.count > 0) {
                NSIndexPath *last = [NSIndexPath indexPathForRow:self.message.count - 1 inSection:0];
                [self.tableView scrollToRowAtIndexPath:last atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.message.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatModel *model = self.message[indexPath.row];
    if (model.type == MessageTypeSelf) {
        RightBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
        [cell updateWithModel:self.message[indexPath.row]];
        return cell;
    } else {
        leftBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
        [cell updateWithModel:self.message[indexPath.row]];
        return cell;
    }
}
- (void)tapAction {
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
