//
//  DetailViewController.h
//  YTSFinal
//
//  Created by Art Sevilla on 3/2/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController

@property (nonatomic, strong) UIImage *moviePoster;

- (void)fetchDetailsForMovieID:(NSString *)movieID;

@end
