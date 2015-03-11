//
//  TextFieldTableViewCell.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/25/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    //self.entryField.layer.cornerRadius = 5.0;
    self.entryField.layer.masksToBounds = YES;
    self.entryField.keyboardAppearance = UIKeyboardAppearanceDark;
}

@end
