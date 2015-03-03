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

@interface DetailViewController ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSDictionary *fullMovieDetails;

@end

static NSString * const reuseIdentifier = @"movieCell";
static NSString * const defaultReuseIdentifier = @"multiCell";

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishWithMovieDetails:) name:@"didFinishWithMovieDetails" object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"MultiLabelTableViewCell" bundle:nil] forCellReuseIdentifier:defaultReuseIdentifier];
    
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
    NSLog(@"Sections: %@", self.sections);
    [self.tableView reloadData];
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
    [[YTSManager sharedManager] fetchMovieDetailsForID:movieID];
}

- (void)didFinishWithMovieDetails:(NSNotification *)notification
{
    NSDictionary *temp = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[notification object]];
    [self createSectionedDetails:temp];
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sections objectAtIndex:section] count];
}

#pragma mark - table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    MultiLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultReuseIdentifier forIndexPath:indexPath];
                    if (!cell) {
                        cell = [[MultiLabelTableViewCell alloc] init];
                    }
                    cell.titleLabel.text = [[[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
                    return cell;
                }
                    break;
                    
                case 1: {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1: {
            
        }
            break;
            
        case 2: {
            
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

@end
