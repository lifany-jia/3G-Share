//
//  SearchVC.m
//  3GShare
//
//  Created by lifany on 2026/5/17.
//

#import "SearchVC.h"

@interface SearchVC ()
@property (nonatomic, strong) UITextField *search;
@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    appearance.backgroundColor = [[UIColor colorWithRed:53.0 / 255.0 green:143.0 / 255.0 blue:203.0 / 255.0 alpha:1.0] colorWithAlphaComponent:0.9];
    appearance.titleTextAttributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:30],
        NSForegroundColorAttributeName:[UIColor whiteColor]
    };
    self.navigationItem.title = @"搜索";
    self.navigationController.navigationBar.standardAppearance = appearance;
    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
//    UIView *searchView = [[UIView alloc] init];
//    [self.view addSubview:searchView];
//    UIImageView *searchIma = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"magnifyingglass"]];
//    [searchView addSubview:searchView];
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
