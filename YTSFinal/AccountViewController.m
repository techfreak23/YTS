//
//  AccountViewController.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/21/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import "AccountViewController.h"
#import "YTSManager.h"
#import "SignUpViewController.h"
#import "LoginViewController.h"
#import "ListViewCell.h"

@interface AccountViewController ()

@property (nonatomic, strong) NSArray *accountItems;

@end

BOOL isLoggedIn;

static NSString *reuseIdentifier = @"listCell";

@implementation AccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isLoggedIn = [[YTSManager sharedManager] isLoggedIn];
    
    if (isLoggedIn) {
        self.accountItems = @[@"View Profile", @"Change Password", @"Logout"];
    } else {
        self.accountItems = @[@"Log in", @"Sign up"];
    }
    
    self.title = @"Account";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissView)];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purple_background"]];
    [self.tableView registerNib:[UINib nibWithNibName:@"ListViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissView
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
    return self.accountItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.label.text = [_accountItems objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.label.layer.shadowRadius = 10.0;
    cell.label.layer.shadowOpacity = .80;
    cell.label.layer.cornerRadius = 10.0;
    cell.label.layer.masksToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoggedIn) {
        switch (indexPath.row) {
            case 0:
                NSLog(@"Button 0");
                break;
                
            case 1:
                NSLog(@"Button 1");
                break;
                
            case 2:
            {
                NSLog(@"Button 2");
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure?" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Logout" otherButtonTitles: nil];
                [actionSheet showInView:self.view];
                break;
            }
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                LoginViewController *controller = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            
            case 1: {
                SignUpViewController *controller = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            
            default:
                break;
        }
    }
}

#pragma mark - Action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button index: %ld", (long)buttonIndex);
    
    switch (buttonIndex) {
        case 0:
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            break;
            
        case 1:
            NSLog(@"Dismissed...");
            
        default:
            break;
    }
}

@end
