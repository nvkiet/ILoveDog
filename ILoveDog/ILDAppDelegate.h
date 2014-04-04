//
//  ILDAppDelegate.h
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/2/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ILDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabbarController;
@property (strong, nonatomic) UINavigationController *navController;

+ (ILDAppDelegate*)shareDelegate;

- (void)showLoginScreen;
- (void)showHomeScreen;

- (void)logOut;

@end
