//
//  BaseTableViewCell.h
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/3/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

+ (CGFloat)getHeight;
- (void)configureWithData: (id)model;

@end
