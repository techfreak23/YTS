//
//  InitialViewController.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/21/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import "YTSManager.h"
#import "InitialViewController.h"
#import "CollectionViewController.h"
#import "AccountViewController.h"
#import "CollectionViewTableViewCell.h"
#import "MoviePosterCollectionViewCell.h"
#import "ListViewCell.h"

@interface InitialViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *upcomingList;
@property (nonatomic, strong) UIActivityIndicatorView *indicationView;

@end

static NSString *reuseIdentifier = @"Cell";
static NSString *collectionIdentifier = @"collectionCell";

@implementation InitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[YTSManager sharedManager] fetchUpcomingList];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.title = @"YTS";
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purple_background"]];
    
    UIBarButtonItem *showAccount = [[UIBarButtonItem alloc] initWithTitle:@"Account" style:UIBarButtonItemStylePlain target:self action:@selector(showAccountView)];
    self.navigationItem.rightBarButtonItem = showAccount;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewTableViewCell" bundle:nil] forCellReuseIdentifier:collectionIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ListViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.scrollEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedWithUpcomingList:) name:@"finishedWithUpcoming" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showAccountView
{
    AccountViewController *controller = [[AccountViewController alloc] initWithNibName:@"AccountViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

- (void)finishedWithUpcomingList:(NSNotification *)notification
{
    self.upcomingList = [[notification object] mutableCopy];
    NSLog(@"Just checking to be sure: %@", self.upcomingList);
    [self.delegate finishedWithUpcomingList:self.upcomingList];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        CollectionViewTableViewCell *upcomingCell = [tableView dequeueReusableCellWithIdentifier:collectionIdentifier forIndexPath:indexPath];
        upcomingCell = [[CollectionViewTableViewCell alloc] init];
        self.indicationView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(upcomingCell.contentView.center.x - 20.0f, cell.contentView.center.y - 20.0f, 40.0f, 40.0f)];
        self.indicationView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [self.indicationView startAnimating];
        upcomingCell.upcomingMovies = self.upcomingList;
        self.delegate = upcomingCell;
        cell = upcomingCell;
        
        [cell.contentView addSubview:self.indicationView];
    } else {
        ListViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        listCell = [[ListViewCell alloc] init];
        listCell.label.text = @"Browse movies";
        listCell.label.layer.shadowColor = [UIColor blackColor].CGColor;
        listCell.label.layer.shadowRadius = 10.0;
        listCell.label.layer.shadowOpacity = .80;
        listCell.label.layer.cornerRadius = 10.0;
        listCell.label.layer.masksToBounds = YES;
        cell = listCell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /*
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.label.text = [self.items objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.label.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.label.layer.shadowRadius = 10.0;
    cell.label.layer.shadowOpacity = .80;
    cell.label.layer.cornerRadius = 10.0;
    cell.label.layer.masksToBounds = YES;
     */
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 215.0f;
    } else {
        return 66.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 215.0f;
    } else {
       return 66.0;
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewController *controller = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
