//
//  CollectionViewTableViewCell.h
//  CollectionViewTest
//
//  Created by Art Sevilla on 2/24/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InitialViewController.h"

@protocol CollectionViewCellDelegate <NSObject>

- (void)didSelectItem:(NSIndexPath *)indexPath;

@end

@interface CollectionViewTableViewCell : UITableViewCell <UpcomingListDelegate>

@property (nonatomic, weak) id <CollectionViewCellDelegate> delegate;
@property (nonatomic, strong) NSArray *upcomingMovies;
@property (nonatomic, strong) NSString *titleKey;
@property (nonatomic, strong) NSString *subtitleKey;
@property (nonatomic, strong) NSString *imageKey;

@end
