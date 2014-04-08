//
//  ILDPhotoWriteCaptionViewController.m
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/7/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import "ILDPhotoWriteCaptionViewController.h"
#import "UIImage+ResizeAdditions.h"

@interface ILDPhotoWriteCaptionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@property (strong, nonatomic) PFFile *photoFile;
@property (strong, nonatomic) PFFile *thumbnailFile;
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
    
    self.commentTextField.delegate = self;
    
    [self resizePhotoImage:self.photoImage];
}

-(void)cancelBarButtonClicked:(id)sender
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishButtonClicked:(id)sender
{
    // Handle user comment
    NSDictionary *userInfo = [NSDictionary dictionary];
    // Remove whitespace around strings.
    NSString *strimedComment = [self.commentTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (strimedComment.length!= 0) {
        userInfo = @{USER_INFO_COMMENT_KEY: strimedComment};
    }
    
    if (!self.photoFile || !self.thumbnailFile) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Couldn't post your photo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    // Create a photo object
    PFObject *photoObject = [PFObject objectWithClassName:PHOTO_CLASS_KEY];
    [photoObject setObject:[PFUser currentUser] forKey:PHOTO_USER_KEY];
    [photoObject setObject:self.photoFile forKey:PHOTO_IMAGE_KEY];
    [photoObject setObject:self.thumbnailFile forKey:PHOTO_THUMBNAIL_KEY];
    
    // Only current user can read or write on this photo object
    PFACL *photoACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [photoACL setPublicReadAccess:YES];
    photoObject.ACL = photoACL;
    
    // CODELATER: Request a background execution task to allow us to finish uploading even if the app is backgrounded
    
    // Save photo object
    [photoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // CODELATER: Cache photo to local disk
            if (userInfo) {
                NSString *commentString = userInfo[USER_INFO_COMMENT_KEY];
                if (commentString.length!= 0) {
                    PFObject *commentObject = [PFObject objectWithClassName:ACTIVITY_CLASS_KEY];
                    [commentObject setObject:ACTIVITY_TYPE_COMMENT forKey:ACTIVITY_TYPE_KEY];
                    [commentObject setObject:photoObject forKey:ACTIVITY_PHOTO_KEY];
                    [commentObject setObject:[PFUser currentUser] forKey:ACTIVITY_FROM_USER_KEY];
                    [commentObject setObject:[PFUser currentUser] forKey:ACTIVITY_TO_USER_KEY];
                    [commentObject setObject:commentString forKey:ACTIVITY_CONTENT_KEY];
                    
                    PFACL *commentACL = [PFACL ACLWithUser:[PFUser currentUser]];
                    [commentACL setPublicReadAccess:YES];
                    commentObject.ACL = commentACL;
                    
                    [commentObject saveEventually];
                    // CODELATER: Increase comment count on this photo
                }
            }
            // CODELATER: Nofify TabbarController to pull data from server (using NSNotificationCenter)
            NSLog(@"Save photo object success!");
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Couldn't post your photo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)resizePhotoImage: (UIImage*)originImage
{
    // CODELATER: What to do if the photo is too small
    UIImage *resizeImageData = [originImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(560.0f, 560.0f) interpolationQuality:kCGInterpolationHigh];
    UIImage *resizeThumbnailData = [originImage thumbnailImage:86.0f transparentBorder:0.0f cornerRadius:10.0f interpolationQuality:kCGInterpolationDefault];
    
    NSData *imageData = UIImageJPEGRepresentation(resizeImageData, 0.8f);
    NSData *thumbnailData = UIImagePNGRepresentation(resizeThumbnailData);
    
    self.photoFile = [PFFile fileWithData:imageData];
    self.thumbnailFile = [PFFile fileWithData:thumbnailData];
    
    // CODELATER: Request a background executask to finish uploading photo
    [self.photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.thumbnailFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Save thumbnail file success!");
                }
            }];
        }
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self publishButtonClicked:nil];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

- (void)animateTextField: (UITextField*)textField up: (BOOL)up
{
    const CGFloat movementDistance = 120.0f;
    const CGFloat movementDuration = 0.3f;
    int movement = (up ? -movementDistance: movementDistance);
    
    [UIView animateWithDuration:movementDuration animations:^{
        self.containerView.frame = CGRectOffset(self.containerView.frame, 0, movement);
    }];
}

- (IBAction)backgroundButtonClicked:(id)sender {
    [self.commentTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
