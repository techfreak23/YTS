//
//  CollectionViewTableViewCell.h
//  CollectionViewTest
//
//  Created by Art Sevilla on 2/24/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InitialViewController.h"

@interface CollectionViewTableViewCell : UITableViewCell <UpcomingListDelegate>

@property (nonatomic, strong) NSArray *upcomingMovies;

@end
