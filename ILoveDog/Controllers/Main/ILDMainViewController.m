//
//  ILDMainViewController.m
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/2/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import "ILDMainViewController.h"

@interface ILDMainViewController ()

@property (strong, nonatomic) IBOutlet UITabBarController *tabbarVC;


@end

@implementation ILDMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    self.tabbarVC.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    [self.view addSubview:self.tabbarVC.view];
    
    UITabBarItem *homeTB = [self.tabbarVC.tabBar.items objectAtIndex:0];
    UITabBarItem *postTB = [self.tabbarVC.tabBar.items objectAtIndex:1];
    UITabBarItem *profileTB = [self.tabbarVC.tabBar.items objectAtIndex:2];
    
    // Set offset for tabbar items images.
    UIEdgeInsets imageInsets = UIEdgeInsetsMake(0, 0, -8, 0);
    
    [homeTB setSelectedImage:[self getImageWithDefaultRenderingMode:@"home_tabbar_active.png"]];
    [homeTB setImage:[self getImageWithDefaultRenderingMode:@"home_tabbar.png"]];
    homeTB.imageInsets = imageInsets;

    [profileTB setSelectedImage:[self getImageWithDefaultRenderingMode:@"home_tabbar_active.png"]];
    [profileTB setImage:[self getImageWithDefaultRenderingMode:@"home_tabbar.png"]];
    profileTB.imageInsets = imageInsets;
    
    UIEdgeInsets imageInset = UIEdgeInsetsMake(-4, 0, -8, 0);
    [postTB setImage:[self getImageWithDefaultRenderingMode:@"post_tabbar.png"]];
    postTB.imageInsets = imageInset;
}

#pragma mark - Image Hepler

- (UIImage*)getImageWithDefaultRenderingMode: (NSString*)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
