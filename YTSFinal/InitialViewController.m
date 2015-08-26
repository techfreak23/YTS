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

@interface InitialViewController () <UIAlertViewDelegate, UIActionSheetDelegate, CollectionViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *upcomingList;
@property (nonatomic, strong) UIActivityIndicatorView *indicationView;

@end

static NSString *reuseIdentifier = @"listCell";
static NSString *collectionIdentifier = @"collectionCell";

@implementation InitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[YTSManager sharedManager] fetchUpcomingList];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.title = @"YTS";
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purple_background"]];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f]};
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showAccountView)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewTableViewCell" bundle:nil] forCellReuseIdentifier:collectionIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ListViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.scrollEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedWithUpcomingList:) name:@"finishedWithUpcoming" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedWithError:) name:@"didFinishWithError" object:nil];
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
    [self.indicationView stopAnimating];
    [self.delegate setCollectionDataSource:self.upcomingList];
}

- (void)finishedWithError:(NSNotification *)notification
{
    [self.indicationView stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong with the request. Please try again later." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
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
    if (indexPath.row == 0) {
        CollectionViewTableViewCell *upcomingCell = [tableView dequeueReusableCellWithIdentifier:collectionIdentifier forIndexPath:indexPath];
        if (!upcomingCell) {
            upcomingCell = [[CollectionViewTableViewCell alloc] init];
        }
        
        self.indicationView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(upcomingCell.contentView.center.x - 20.0f, upcomingCell.contentView.center.y - 20.0f, 40.0f, 40.0f)];
        self.indicationView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [self.indicationView startAnimating];
        upcomingCell.dataSource = self.upcomingList;
        self.delegate = upcomingCell;
        
        upcomingCell.tag = indexPath.row;
        upcomingCell.delegate = self;
        upcomingCell.titleKey = @"title";
        upcomingCell.imageKey = @"medium_cover_image";
        upcomingCell.selectionStyle = UITableViewCellSelectionStyleNone;
        upcomingCell.backgroundColor = [UIColor clearColor];
        
        [upcomingCell.contentView addSubview:self.indicationView];
        return upcomingCell;
        
    } else if (indexPath.row == 1) {
        ListViewCell *listCell = (ListViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        if (!listCell) {
            listCell = [[ListViewCell alloc] init];
        }
        
        listCell.label.text = @"Browse movies";
        listCell.label.layer.shadowColor = [UIColor blackColor].CGColor;
        listCell.label.layer.shadowRadius = 10.0;
        listCell.label.layer.shadowOpacity = .80;
        listCell.label.layer.cornerRadius = 2.0;
        listCell.label.layer.masksToBounds = YES;
        
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return listCell;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.font = [UIFont systemFontOfSize:15.0f];
    headerLabel.textColor = [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f];
    headerLabel.text = [NSString stringWithFormat:@" Upcoming movies"];
    
    return headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 235.0f;
    } else {
        return 66.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 235.0f;
    } else {
       return 66.0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        CollectionViewController *controller = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - collection table view cell delegate method

- (void)didSelectItem:(NSIndexPath *)indexPath forCell:(UITableViewCell *)cell
{
    
    NSLog(@"CollectionCell tag: %ld", (long)cell.tag);
    NSDictionary *temp = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[self.upcomingList objectAtIndex:indexPath.item]];
    NSLog(@"From initial: %ld upcoming item: %@", (long)indexPath.row, [temp objectForKey:@"imdb_code"]);
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in IMDB", nil];
    actionSheet.tag = indexPath.item;
    [actionSheet showInView:self.view];
}

#pragma mark - action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDictionary *temp = [self.upcomingList objectAtIndex:actionSheet.tag];
    NSString *urlString = [temp objectForKey:@"imdb_code"];
    
    if (buttonIndex == 0) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"imdb:///title/%@/", urlString]]]) {
            NSLog(@"We are opening in IMDB: %@", temp);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"imdb:///title/%@/", urlString]]];
        } else {
            NSLog(@"We are cancelling...");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://imdb.com/title/%@/", urlString]]];
        }
    } else {
        NSLog(@"We're cancelling...");
    }
}

@end
