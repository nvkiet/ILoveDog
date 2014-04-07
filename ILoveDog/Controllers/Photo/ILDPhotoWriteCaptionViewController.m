//
//  ILDPhotoWriteCaptionViewController.m
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/7/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import "ILDPhotoWriteCaptionViewController.h"

@interface ILDPhotoWriteCaptionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@end

@implementation ILDPhotoWriteCaptionViewController

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
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBarButtonClicked:)];
    self.navItem.leftBarButtonItem = cancelBarButton;
    
    UIBarButtonItem *publishBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Publish" style:UIBarButtonItemStyleBordered target:self action:@selector(publishButtonClicked:)];
    self.navItem.rightBarButtonItem = publishBarButton;
    
    self.photoImageView.image = self.photoImage;
}

-(void)cancelBarButtonClicked:(id)sender
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishButtonClicked:(id)sender
{
    // Publish photo
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
