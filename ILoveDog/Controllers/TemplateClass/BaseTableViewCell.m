//
//  BaseTableViewCell.m
//  ILoveDog
//
//  Created by KIET NGUYEN on 4/3/14.
//  Copyright (c) 2014 Kiet Nguyen. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithData:(id)model
{
    //DLog(@"WARNING: subclass to override this");
}

+(CGFloat)getHeight
{
    return 44;
}

@end
