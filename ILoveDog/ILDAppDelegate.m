//
//  ILDAppDelegate.m
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/2/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import "ILDAppDelegate.h"
#import "ILDLoginViewController.h"
#import "ILDRootViewController.h"


#import "ILDHomeRootViewController.h"
#import "ILDExploreRootViewController.h"
#import "ILDPostRootViewController.h"
#import "ILDNotificaionRootViewController.h"
#import "ILDProfileRootViewController.h"

@interface ILDAppDelegate()

@property (nonatomic, strong) ILDRootViewController *rootVC;

@property (nonatomic, strong) ILDHomeRootViewController *homeRootVC;
@property (nonatomic, strong) ILDExploreRootViewController *exploreRootVC;
@property (nonatomic, strong) ILDPostRootViewController *postRootViewVC;
@property (nonatomic, strong) ILDNotificaionRootViewController *notificationRootVC;
@property (nonatomic, strong) ILDProfileRootViewController *profileVC;

@end

@implementation ILDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Register to use Parse Server
    [Parse setApplicationId:@"FSSQUbrtVnAOzoP1v8D6TR8qeyglIXdc6ceNQbWO"
                  clientKey:@"jjbXAWMlot8CW4WZMbS3I4XaHIyq5rOv91NsYiMm"];
    // Track statistics around application opens
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFFacebookUtils initializeFacebook];
    
    [self setupAppearance];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.rootVC = [[ILDRootViewController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.rootVC];
    self.navController.navigationBarHidden = YES;
    
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

+ (ILDAppDelegate*)shareDelegate
{
    return (ILDAppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)showLoginScreen
{
    [self.rootVC presentViewController: [[ILDLoginViewController alloc] initWithNib] animated:YES completion:nil];
}

- (void)showHomeScreen
{
    self.tabbarController = [[UITabBarController alloc] init];
    
    self.homeRootVC = [[ILDHomeRootViewController alloc] initWithNib];
    UINavigationController *homeVC =  [[UINavigationController alloc] initWithRootViewController:self.homeRootVC];
    
    self.exploreRootVC = [[ILDExploreRootViewController alloc] initWithNib];
    UINavigationController *exploreVC =  [[UINavigationController alloc] initWithRootViewController:self.exploreRootVC];
    
    self.postRootViewVC = [[ILDPostRootViewController alloc] initWithNib];
    UINavigationController *postViewVC =  [[UINavigationController alloc] initWithRootViewController:self.postRootViewVC];
    
    self.notificationRootVC = [[ILDNotificaionRootViewController alloc] initWithNib];
    UINavigationController *notificationVC =  [[UINavigationController alloc] initWithRootViewController:self.notificationRootVC];
    
    self.profileVC = [[ILDProfileRootViewController alloc] initWithNib];
    UINavigationController *profileVC =  [[UINavigationController alloc] initWithRootViewController:self.profileVC];
    
    self.tabbarController.viewControllers = @ [ homeVC, exploreVC, postViewVC, notificationVC, profileVC];
    
    [[self.tabbarController.tabBar.items objectAtIndex:0] setTitle:@"Home"];
    [[self.tabbarController.tabBar.items objectAtIndex:1] setTitle:@"Explore"];
    [[self.tabbarController.tabBar.items objectAtIndex:2] setTitle:@"Post"];
    [[self.tabbarController.tabBar.items objectAtIndex:3] setTitle:@"Notification"];
    [[self.tabbarController.tabBar.items objectAtIndex:4] setTitle:@"Profile"];
    
    [self.rootVC presentViewController: self.tabbarController animated:NO completion:nil];
    
    //[self.navController setViewControllers:@[ self.rootVC, self.tabbarController ] animated:NO];
}

- (void)logOut
{
    [PFUser logOut];
    
    self.homeRootVC = nil;
    self.exploreRootVC = nil;
    self.postRootViewVC = nil;
    self.notificationRootVC = nil;
    self.profileVC = nil;
}

- (void)setupAppearance
{
    UIImage *navBkg = [UIImage imageNamed:@"navi_bar_full.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBkg forBarMetrics:UIBarMetricsDefault];
    
//    UIImage *tabbarBkg = [UIImage imageNamed:@"tabbar.png"];
//    [[UITabBar appearance] setBackgroundImage:tabbarBkg];
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:FONT_HELVETICAL_REGULAR size:18.0f]
                                                        }];
}

// App switching methods to support Facebook Single Sign-On.
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[PFFacebookUtils session] close];
}

@end
