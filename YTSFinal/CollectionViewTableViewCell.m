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

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end

static NSString *reuseIdentifier = @"movieCell";

@implementation CollectionViewTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MoviePosterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
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
    NSLog(@"number of items;");
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
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)", [temp objectForKey:@"title"], [temp objectForKey:@"year"]];
    [cell.imageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    
    return cell;
}

#pragma mark - collection view delegate

- (void)finishedWithUpcomingList:(NSArray *)list
{
    NSLog(@"Press the big red button!");
    self.upcomingMovies = list;
    
    [self.collectionView reloadData];
}

@end
