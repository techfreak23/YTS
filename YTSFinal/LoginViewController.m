//
//  LoginViewController.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/25/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import "LoginViewController.h"
#import "TextFieldTableViewCell.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSArray *loginItems;

@end

static NSString *reuseIdentifier = @"textCell";

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _loginItems = @[@"email", @"password"];
    
    self.title = @"Login";
    
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    loginButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = loginButton;
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purple_background"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login
{
    
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
    return _loginItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.entryField.tag = indexPath.row;
    cell.entryField.delegate = self;
    cell.entryField.placeholder = [_loginItems objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    switch (indexPath.row) {
        case 0: {
            cell.entryField.keyboardType = UIKeyboardTypeEmailAddress;
            cell.entryField.returnKeyType = UIReturnKeyNext;
        }
            break;
            
        case 1: {
            cell.entryField.secureTextEntry = YES;
            cell.entryField.returnKeyType = UIReturnKeyDone;
        }
            
        default:
            break;
    }
    
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

#pragma mark - text field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Text field: %ld", (long)textField.tag);
}

@end
