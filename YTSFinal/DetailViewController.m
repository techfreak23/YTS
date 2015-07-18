//
//  DetailViewController.m
//  YTSFinal
//
//  Created by Art Sevilla on 3/2/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "YTSManager.h"
#import "DetailViewController.h"
#import "AccountViewController.h"
#import "CollectionViewTableViewCell.h"
#import "MultiLabelTableViewCell.h"
#import "TableViewCellFactory.h"

@interface DetailViewController ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSDictionary *fullMovieDetails;

@end

static NSString * const reuseIdentifier = @"movieCell";
static NSString * const defaultReuseIdentifier = @"multiCell";
static NSString * const defaultIdentifier = @"defaultCell";

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishWithMovieDetails:) name:@"didFinishWithMovieDetails" object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"MultiLabelTableViewCell" bundle:nil] forCellReuseIdentifier:defaultReuseIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:defaultIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showAccount)];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purple_background"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)createSectionedDetails:(NSDictionary *)fullDetails
{
    NSArray *temp1 = @[@{@"title": [fullDetails objectForKey:@"title_long"], @"mpa_rating": [fullDetails objectForKey:@"mpa_rating"], @"runtime": [fullDetails objectForKey:@"runtime"], @"genre": [fullDetails objectForKey:@"genres"]}, @{@"rating": [fullDetails objectForKey:@"rating"], @"language": [fullDetails objectForKey:@"language"]}];
    NSArray *temp2 = @[@{@"actors": [fullDetails objectForKey:@"actors"]}, @{@"directors": [fullDetails objectForKey:@"directors"]}];
    NSArray *temp3 = @[@{@"screenshots": [fullDetails objectForKey:@"images"]}];
    
    self.sections = [@[temp1, temp2, temp3] mutableCopy];
    //NSLog(@"Sections: %@", self.sections);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showAccount
{
    AccountViewController *controller = [[AccountViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

- (void)fetchDetailsForMovieID:(NSString *)movieID
{
    //[[YTSManager sharedManager] fetchMovieDetailsForID:movieID];
}

- (void)didFinishWithMovieDetails:(NSNotification *)notification
{
    NSDictionary *temp = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[notification object]];
    self.fullMovieDetails = temp;
    NSLog(@"Full movie details: %@", self.fullMovieDetails);
    [self createSectionedDetails:temp];
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

#pragma mark - table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    MultiLabelTableViewCell *cell = (MultiLabelTableViewCell *)[[TableViewCellFactory factory] tableView:tableView withStyle:TableViewCellStyleMulti forIndexPath:indexPath];
                    
                    return cell;
                }
                    break;
                    
                case 1: {
                    UITableViewCell *plainCell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier];
                    if (!plainCell) {
                        plainCell = [[UITableViewCell alloc] init];
                        plainCell.imageView.image = self.moviePoster;
                        plainCell.backgroundColor = [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f];
                        return plainCell;
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1: {
            NSArray *temp = [[self.sections objectAtIndex:indexPath.section] objectForKey:@"actors"];
            switch (indexPath.row) {
                case 0: {
                    CollectionViewTableViewCell *cell = (CollectionViewTableViewCell *)[[TableViewCellFactory factory] tableView:tableView withStyle:TableViewCellStyleCollectionView forIndexPath:indexPath];
                    
                    return cell;
                }
                    break;
                    
                case 1: {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier forIndexPath:indexPath];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] init];
                    }
                    cell.textLabel.text = @"Directors go here!";
                    return cell;
                }
                    break;
            }
        }
            break;
            
        case 2: {
            CollectionViewTableViewCell *cell = (CollectionViewTableViewCell *)[[TableViewCellFactory factory] tableView:tableView withStyle:TableViewCellStyleCollectionView forIndexPath:indexPath];
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultIdentifier];
    }
    
    cell.textLabel.text = @"Test";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.0f;
}

@end
