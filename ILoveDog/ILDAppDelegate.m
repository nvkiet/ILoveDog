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
#import "ILDNotificaionRootViewController.h"
#import "ILDProfileRootViewController.h"
#import "ILDPhotoWriteCaptionViewController.h"

#define POST_TABBAR_ITEM 2

@interface ILDAppDelegate()

@property (nonatomic, strong) ILDRootViewController *rootVC;

@property (nonatomic, strong) ILDHomeRootViewController *homeRootVC;
@property (nonatomic, strong) ILDExploreRootViewController *exploreRootVC;
@property (nonatomic, strong) ILDNotificaionRootViewController *notificationRootVC;
@property (nonatomic, strong) ILDProfileRootViewController *profileVC;

@property (nonatomic) int prevTabBarIndex;
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
    self.tabbarController.delegate = self;
    
    self.homeRootVC = [[ILDHomeRootViewController alloc] initWithNib];
    UINavigationController *homeNC =  [[UINavigationController alloc] initWithRootViewController:self.homeRootVC];
    
    self.exploreRootVC = [[ILDExploreRootViewController alloc] initWithNib];
    UINavigationController *exploreNC =  [[UINavigationController alloc] initWithRootViewController:self.exploreRootVC];

    UINavigationController *postViewNC =  [[UINavigationController alloc] init];
    
    self.notificationRootVC = [[ILDNotificaionRootViewController alloc] initWithNib];
    UINavigationController *notificationNC =  [[UINavigationController alloc] initWithRootViewController:self.notificationRootVC];
    
    self.profileVC = [[ILDProfileRootViewController alloc] initWithNib];
    UINavigationController *profileNC =  [[UINavigationController alloc] initWithRootViewController:self.profileVC];
    
    self.tabbarController.viewControllers = @ [ homeNC, exploreNC, postViewNC, notificationNC, profileNC];
    
    [[self.tabbarController.tabBar.items objectAtIndex:0] setTitle:@"Home"];
    [[self.tabbarController.tabBar.items objectAtIndex:1] setTitle:@"Explore"];
    UITabBarItem *postTabBar = [self.tabbarController.tabBar.items objectAtIndex:2];
    //[postTabBar setTitle:@"Post"];
    postTabBar.tag = POST_TABBAR_ITEM;
    [[self.tabbarController.tabBar.items objectAtIndex:3] setTitle:@"Notification"];
    [[self.tabbarController.tabBar.items objectAtIndex:4] setTitle:@"Profile"];
    
    [self.rootVC presentViewController: self.tabbarController animated:NO completion:nil];
    
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cameraButton setTitle:@"Camera" forState:UIControlStateNormal];
//    [cameraButton setImage:[UIImage imageNamed:@"ButtonCamera.png"] forState:UIControlStateNormal];
//    [cameraButton setImage:[UIImage imageNamed:@"ButtonCameraSelected.png"] forState:UIControlStateHighlighted];
    cameraButton.frame = CGRectMake(129.0f, 0.0f, 64.0f, self.tabbarController.tabBar.bounds.size.height);
    [cameraButton addTarget:self action:@selector(photoCaptureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbarController.tabBar addSubview:cameraButton];
}

#pragma mark - Actions

- (void)photoCaptureButtonClicked:(id)sender
{
    UIActionSheet *photoActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Choose Photo", nil];
    [photoActionSheet showFromTabBar:self.tabbarController.tabBar];
}

- (void)logOut
{
    [PFUser logOut];
    
    self.homeRootVC = nil;
    self.exploreRootVC = nil;
    self.notificationRootVC = nil;
    self.profileVC = nil;
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController.tabBarItem.tag == POST_TABBAR_ITEM){
        return NO;
    }
    return YES;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            // Take picture
            [self takePhoto];
            break;
        case 1:
            // Choose picture
            [self choosePhoto];
            break;
        default:
            break;
    }
}
- (void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self.tabbarController presentViewController:imagePickerController animated:YES completion:nil];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Take Photo Failed" message:@"Device has no camera." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)choosePhoto
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.tabbarController presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerEditedImage];
        ILDPhotoWriteCaptionViewController *photoWriteCaptionVC = [[ILDPhotoWriteCaptionViewController alloc] initWithNib];
        photoWriteCaptionVC.photoImage = image;
        
        [self.tabbarController presentViewController:photoWriteCaptionVC animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
