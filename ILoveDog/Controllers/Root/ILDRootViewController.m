//
//  ILDRootViewController.m
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/4/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import "ILDRootViewController.h"

@interface ILDRootViewController ()

@end

@implementation ILDRootViewController

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
    
    // Set background image
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    backgroundImageView.frame = self.view.frame;
    
    [self.view addSubview:backgroundImageView];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Check If User logined and wheather user's account linked to facebook
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [[ILDAppDelegate shareDelegate] showHomeScreen];
    }
    else {
        [[ILDAppDelegate shareDelegate] showLoginScreen];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
