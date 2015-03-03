//
//  CollectionViewTableViewCell.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 2/24/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "CollectionViewTableViewCell.h"
#import "MoviePosterCollectionViewCell.h"

@interface UIImage (UIColor)

@end

@implementation UIImage (UIColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@interface CollectionViewTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

static NSString *reuseIdentifier = @"movieCell";

@implementation CollectionViewTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MoviePosterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"number of items: %lu", (unsigned long)self.upcomingMovies.count);
    return self.upcomingMovies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoviePosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *temp = [self.upcomingMovies objectAtIndex:indexPath.item];
    NSString *urlString = (NSString *)[temp objectForKey:@"medium_cover_image"];
    
    if (!cell) {
        cell = [[MoviePosterCollectionViewCell alloc] init];
    }
    
    cell.titleLabel.numberOfLines = 0;
    cell.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)", [temp objectForKey:@"title"], [temp objectForKey:@"year"]];
    [cell.imageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    
    [cell.layer setShadowPath:[UIBezierPath bezierPathWithRect:cell.bounds].CGPath];
    
    return cell;
}

#pragma mark - collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItem:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.opacity = 0.0f;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowOpacity = 0.0f;
    cell.layer.shadowRadius = 0.0f;
    
    [UIView animateWithDuration:0.25f animations:^{
        cell.layer.opacity = 1.0f;
        cell.layer.shadowOpacity = .65f;
        cell.layer.shadowRadius = 15.0f;
    }];
}

- (void)finishedWithUpcomingList:(NSArray *)list
{
    self.upcomingMovies = list;
    
    [self.collectionView reloadData];
}

@end
