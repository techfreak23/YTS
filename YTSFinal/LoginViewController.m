//
//  LoginViewController.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/25/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import "LoginViewController.h"
#import "TextFieldTableViewCell.h"
#import "YTSManager.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSArray *loginItems;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passField;

@end

static NSString *reuseIdentifier = @"textCell";

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoggedInSuccessfully:) name:@"didLoginSuccessfully" object:nil];
    
    self.loginItems = @[@"email", @"password"];
    
    self.title = @"Login";
    
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = loginButton;
    
    [self validateTextFields];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purple_background"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)userLoggedInSuccessfully:(NSNotification *)notification
{
    NSLog(@"Notification: %@", notification);
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)login
{
    [self.view endEditing:YES];
    if ([self validateEmailField:self.emailField.text]) {
        [[YTSManager sharedManager] loginWithUsername:self.emailField.text password:self.passField.text];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"It looks like you did not enter a valid email address." delegate:self cancelButtonTitle:@"Got it!" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.loginItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.entryField.tag = indexPath.row;
    cell.entryField.delegate = self;
    cell.entryField.placeholder = [self.loginItems objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    switch (indexPath.row) {
        case 0: {
            cell.entryField.keyboardType = UIKeyboardTypeEmailAddress;
            cell.entryField.returnKeyType = UIReturnKeyNext;
            self.emailField = cell.entryField;
        }
            break;
            
        case 1: {
            cell.entryField.secureTextEntry = YES;
            cell.entryField.returnKeyType = UIReturnKeyDone;
            self.passField = cell.entryField;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self validateTextFields];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Text field: %ld", (long)textField.tag);
}

- (void)validateTextFields
{
    if (self.emailField.text.length < 5 || self.passField.text.length < 6) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (BOOL)validateEmailField:(NSString *)email
{
    NSString *filterString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSPredicate *emailPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    
    return [emailPred evaluateWithObject:email];
}

@end
