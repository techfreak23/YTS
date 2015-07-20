//
//  CollectionViewController.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/20/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import "CollectionViewController.h"
#import "MoviePosterCollectionViewCell.h"
#import "DetailViewController.h"
#import "AccountViewController.h"
#import "YTSManager.h"
#import "YTSMovie+API.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

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

@interface CollectionViewController ()

@property (nonatomic, strong) NSMutableArray *movieItems;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"movieCell";
int page = 1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //CGRect navFrame = self.navigationController.navigationBar.frame;
    //CGRect statFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.center.x - 50.0f, self.view.center.y - 50.0f, 100.0f, 100.0f)];
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    [[YTSManager sharedManager] browseMovieListWithLimit:@"30" page:page];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishFetchingMovies:) name:@"didFinishFetchingMovieList" object:nil];
    
    self.title = @"Browse";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showAccount)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.collectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purple_background"]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MoviePosterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didFinishFetchingMovies:(NSNotification *)notification
{
    NSArray *temp = [NSArray arrayWithArray:(NSArray *)[notification object]];
    
    if (!self.movieItems) {
        self.movieItems = [temp mutableCopy];
        [self.collectionView reloadData];
    } else {
        NSMutableArray *indexPaths = [@[] mutableCopy];
        
        int movieCount = (int)self.movieItems.count, tempCount = (int)temp.count;
        
        for (int i = movieCount; i < movieCount + tempCount; i++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            [indexPaths addObject:path];
        }
        
        [self.movieItems addObjectsFromArray:temp];
        
        [self.collectionView insertItemsAtIndexPaths:indexPaths];
    }
    [self.indicatorView stopAnimating];
    [self.indicatorView removeFromSuperview];
}

- (void)showAccount
{
    AccountViewController *controller = [[AccountViewController alloc] initWithNibName:@"AccountViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.movieItems.count > 0) {
        return self.movieItems.count + 1;
    } else {
        return self.movieItems.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoviePosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.numberOfLines = 0;
    
    if (indexPath.item == self.movieItems.count) {
        cell.imageView.image = [UIImage imageWithColor:[UIColor grayColor]];
        cell.titleLabel.text = @"Loading more movies...";
        CGRect frame = CGRectMake(cell.contentView.center.x - 20.0f, cell.contentView.center.y - 20.0f, 40.0f, 40.0f);
        
        self.indicatorView.frame = frame;
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [self.indicatorView startAnimating];
        [cell.contentView addSubview:self.indicatorView];
        
    } else {
        NSDictionary *temp = [self.movieItems objectAtIndex:indexPath.row];
        NSString *imageURL = [temp objectForKey:@"medium_cover_image"];
        
        cell.titleLabel.text = [temp objectForKey:@"title_long"];
        [cell.imageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
    }
    
    [cell.layer setShadowPath:[UIBezierPath bezierPathWithRect:cell.bounds].CGPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did select cell: %ld", (long)indexPath.row);
    
    MoviePosterCollectionViewCell *cell = (MoviePosterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (indexPath.item == self.movieItems.count) {
        NSLog(@"This is the final movie ");
    } else {
        NSDictionary *temp = [self.movieItems objectAtIndex:indexPath.item];
        
        DetailViewController *controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        
        controller.moviePoster = cell.imageView.image;
        //controller.title = [temp objectForKey:@"title_long"];
        [controller fetchDetailsForMovieID:[temp objectForKey:@"id"]];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.layer.opacity = 0.0f;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowOpacity = 0.0f;
    cell.layer.shadowRadius = 0.0f;
    
    [UIView animateWithDuration:0.35f animations:^{
        cell.layer.opacity = 1.0f;
        cell.layer.shadowOpacity = .65f;
        cell.layer.shadowRadius = 15.0f;
    }];
    
    UIActivityIndicatorView *tempView = (UIActivityIndicatorView *)[self.view viewWithTag:1000];
    [tempView stopAnimating];
    
    if (indexPath.item == self.movieItems.count) {
        [[YTSManager sharedManager] browseMovieListWithLimit:@"30" page:++page];
    }
}

@end
