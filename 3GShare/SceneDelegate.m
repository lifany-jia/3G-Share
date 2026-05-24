//
//  SceneDelegate.m
//  3GShare
//
//  Created by lifany on 2026/5/13.
//

#import "SceneDelegate.h"
#import "LoginVC.h"

// 试验
#import "SearchVC.h"
#import "HomeVC.h"
#import "TaskVC.h"
#import "ArticleVC.h"
#import "PersonVC.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    // 键盘弹起后LoginVC.view上移回漏出window的视图，所以要修改window的backgroundColor
    self.window.backgroundColor = [UIColor colorWithRed:53.0/255.0
                                                      green:143.0/255.0
                                                       blue:203.0/255.0
                                                      alpha:1.0];
    LoginVC *login = [[LoginVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    // 试验
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    
    HomeVC *home = [[HomeVC alloc] init];
    home.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage systemImageNamed:@"house"] selectedImage:[UIImage systemImageNamed:@"house.fill"]];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    
    SearchVC *search = [[SearchVC alloc] init];
    search.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage systemImageNamed:@"magnifyingglass"] selectedImage:[UIImage systemImageNamed:@"magnifyingglass.circle.fill"]];
    UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:search];
    
    ArticleVC *article = [[ArticleVC alloc] init];
    article.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage systemImageNamed:@"square.and.pencil"] selectedImage:[UIImage systemImageNamed:@"pencil"]];
    UINavigationController *articleNav = [[UINavigationController alloc] initWithRootViewController:article];
    
    TaskVC *task = [[TaskVC alloc] init];
    task.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage systemImageNamed:@"trophy"] selectedImage:[UIImage systemImageNamed:@"trophy.fill"]];
    UINavigationController *taskNav = [[UINavigationController alloc] initWithRootViewController:task];
    
    PersonVC *person = [[PersonVC alloc] init];
    person.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage systemImageNamed:@"person.crop.circle"] selectedImage:[UIImage systemImageNamed:@"person.circle.fill"]];
    UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:person];
    tabBarVC.viewControllers = @[homeNav, searchNav, articleNav, taskNav, personNav];
    

    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
