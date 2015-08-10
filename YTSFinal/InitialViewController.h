//
//  InitialViewController.h
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/21/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol UpcomingListDelegate <NSObject>

- (void)setCollectionDataSource:(NSArray *)dataSource;

@end

@interface InitialViewController : UITableViewController

@property (nonatomic, weak) id <UpcomingListDelegate> delegate;

@end
