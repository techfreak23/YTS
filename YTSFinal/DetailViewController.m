//
//  DetailViewController.m
//  CollectionViewTest
//
//  Created by Art Sevilla on 11/21/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import "DetailViewController.h"
#import "AccountViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    NSLog(@"View is loading...");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *accountButton = [[UIBarButtonItem alloc] initWithTitle:@"Account" style:UIBarButtonItemStylePlain target:self action:@selector(showAccount)];
    self.navigationItem.rightBarButtonItem = accountButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAccount
{
    AccountViewController *controller = [[AccountViewController alloc] initWithNibName:@"AccountViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

@end
