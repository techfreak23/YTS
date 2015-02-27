//
//  ListViewCell.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/21/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

- (void)awakeFromNib
{
    // Initialization code
    
}

- (void)layoutSubviews
{
    NSLog(@"Laying out subviews...");
    
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    
    self.label.preferredMaxLayoutWidth = self.label.frame.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
