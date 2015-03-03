//
//  SignUpViewController.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/25/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import "SignUpViewController.h"
#import "TextFieldTableViewCell.h"

@interface SignUpViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSArray *signUpItems;

@end

static NSString *reuseIdentifier = @"textCell";

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Sign up";
    
    _signUpItems = @[@"email", @"password", @"confirm password"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign up" style:UIBarButtonItemStylePlain target:self action:@selector(signUp)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purple_background"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)signUp
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
    return _signUpItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.entryField.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.entryField.tag = indexPath.row;
    cell.backgroundColor = [UIColor clearColor];
    
    switch (indexPath.row) {
        case 0: {
            cell.entryField.placeholder = @"email";
            cell.entryField.keyboardType = UIKeyboardTypeEmailAddress;
            cell.entryField.returnKeyType = UIReturnKeyNext;
            [cell.entryField becomeFirstResponder];
        }
            break;
        
        case 1: {
            cell.entryField.placeholder = @"password";
            cell.entryField.secureTextEntry = YES;
            cell.entryField.returnKeyType = UIReturnKeyNext;
        }
            break;
            
        case 2: {
            cell.entryField.placeholder = @"confirm password";
            cell.entryField.secureTextEntry = YES;
            cell.entryField.returnKeyType = UIReturnKeyDone;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *footerLabel = [[UILabel alloc] init];
    
    footerLabel.textColor = [UIColor greenColor];
    footerLabel.text = @"Password must be at least 7 characters long.";
    footerLabel.font = [UIFont systemFontOfSize:12.0];
    footerLabel.backgroundColor = [UIColor clearColor];
    
    return footerLabel;
}

#pragma mark - Text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self validateTextFields:textField];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)validateTextFields:(UITextField *)sender
{
    //UITextField *temp1 = (UITextField *)[self.view viewWithTag:0];
    NSLog(@"Temp 1 text: %@", sender.text);
    NSLog(@"Validating text fields...");
    switch (sender.tag) {
        case 0:
            NSLog(@"Email text field...");
            break;
            
        case 1:
            NSLog(@"Password text field...");
            break;
            
        case 2:
            NSLog(@"Confirm text field...");
            break;
            
        default:
            break;
    }
}

@end
