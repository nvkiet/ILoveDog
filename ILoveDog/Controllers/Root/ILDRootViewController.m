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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[ILDAppDelegate shareDelegate] showHomeScreen];
    
//    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
//        [[ILDAppDelegate shareDelegate] showHomeScreen];
//    }
//    else {
//        [[ILDAppDelegate shareDelegate] showLoginScreen];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
