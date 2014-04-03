//
//  ILDHomeRootViewController.m
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/2/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import "ILDHomeRootViewController.h"
#import "ILDDogViewCell.h"

@interface ILDHomeRootViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ILDHomeRootViewController

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

    UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    navTitleLabel.text = @"I LOVE DOGS";
    navTitleLabel.textColor = [UIColor whiteColor];
    navTitleLabel.font = [UIFont fontWithName:FONT_HELVETICAL_REGULAR size:18];
    
    self.navigationItem.titleView = navTitleLabel;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ILDDogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ILDDogViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell configureWithData:nil];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ILDDogViewCell getHeight];
}


 #pragma mark - Table view delegate
 
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
 

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
