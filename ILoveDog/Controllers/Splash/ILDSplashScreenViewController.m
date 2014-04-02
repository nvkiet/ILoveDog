//
//  ILDSplashScreenViewController.m
//  ILoveDog
//
//  Created by Nguyen Van Kiet on 4/2/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import "ILDSplashScreenViewController.h"
#import "ILDMainViewController.h"

@interface ILDSplashScreenViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *splashImageView;

@end

@implementation ILDSplashScreenViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    ILDMainViewController *mainVC = [[ILDMainViewController alloc] initWithNib];
    [self presentViewController:mainVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
