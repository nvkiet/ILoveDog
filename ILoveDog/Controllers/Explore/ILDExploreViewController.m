//
//  ILDExploreViewController.m
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/3/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import "ILDExploreViewController.h"
#import "ILDExploreRootViewController.h"

@interface ILDExploreViewController ()

@end

@implementation ILDExploreViewController

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
	
    ILDExploreRootViewController *rootVC = [[ILDExploreRootViewController alloc] initWithNib];
    [self pushViewController:rootVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
