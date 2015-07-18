//
//  DetailViewController.h
//  YTSFinal
//
//  Created by Art Sevilla on 3/2/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTSActor.h"

@interface DetailViewController : UITableViewController

@property (nonatomic, strong) UIImage *moviePoster;
@property (nonatomic, strong) YTSMovie *movie;

- (void)fetchDetailsForMovieID:(NSString *)movieID;

@end
