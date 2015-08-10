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
#import "IVTVTableViewCell.h"
#import "MultiLabelTableViewCell.h"
#import "TableViewCellFactory.h"

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

@interface DetailViewController ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSDictionary *fullMovieDetails;

@end

static NSString * const reuseIdentifier = @"movieCell";
static NSString * const imageViewCellIdentifier = @"imageViewCell";
static NSString * const defaultIdentifier = @"defaultCell";

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishWithMovieDetails:) name:@"didFinishWithMovieDetails" object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"IVTVTableViewCell" bundle:nil] forCellReuseIdentifier:imageViewCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:defaultIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showAccount)];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purple_background"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.hidden = TRUE;
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
    [[YTSManager sharedManager] fetchMovieDetailsForID:movieID];
}

- (void)didFinishWithMovieDetails:(NSNotification *)notification
{
    NSDictionary *temp = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[notification object]];
    self.fullMovieDetails = temp;
    NSLog(@"Full movie details: %@", self.fullMovieDetails);
    self.tableView.hidden = FALSE;
    [self.tableView reloadData];
}

- (NSString *)createSubtitleLabelString {
    
    NSString *ratingString = [self.fullMovieDetails objectForKey:@"mpa_rating"];
    NSString *runtimeString = [self.fullMovieDetails objectForKey:@"runtime"];
    NSArray *genres = [self.fullMovieDetails objectForKey:@"genres"];
    NSString *genresString = [genres componentsJoinedByString:@", "];
    
    
    NSLog(@"Genre string: %@", genresString);
    
    return [NSString stringWithFormat:@"%@ | %@ | %@", ratingString, runtimeString, genresString];
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.fullMovieDetails) {
        return 0;
    }
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.0f;
}

#pragma mark - table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"titleCell"];
            }
            
            NSString *title = [NSString stringWithFormat:@"%@", [self.fullMovieDetails objectForKey:@"title_long"]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
            cell.textLabel.textColor = [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f];
            cell.textLabel.text = title;
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
            cell.detailTextLabel.text = [self createSubtitleLabelString];
            
            return cell;
        }
            break;
            
        case 1: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultIdentifier];
            }
            
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFullDescription:)];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.imageView.image = self.moviePoster;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:16.0];
            cell.textLabel.textColor = [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.fullMovieDetails objectForKey:@"description_intro"]];
            [cell.textLabel setUserInteractionEnabled:TRUE];
            [cell.textLabel addGestureRecognizer:recognizer];
            
            return cell;
        }
            break;
            
        case 2: {
            
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultIdentifier];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont systemFontOfSize:16.0];
            cell.textLabel.textColor = [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f];
            cell.textLabel.text = @"Screenshots";
            
            return cell;
        }
            break;
            
        case 3: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultIdentifier];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont systemFontOfSize:16.0];
            cell.textLabel.textColor = [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f];
            cell.textLabel.text = @"Actors";
            
            return cell;
        }
            break;
            
        case 4: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultIdentifier];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont systemFontOfSize:16.0];
            cell.textLabel.textColor = [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f];
            cell.textLabel.text = @"Directors";
            
            return cell;
        }
            break;
            
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultIdentifier];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont systemFontOfSize:16.0];
            cell.textLabel.textColor = [UIColor colorWithRed:53.0/255.0f green:203.0/255.0f blue:14.0/255.0f alpha:1.0f];
            cell.textLabel.text = @"";
            
            return cell;
        }
            break;
            
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.layer.opacity = 0.0f;
    
    [UIView animateWithDuration:0.35f animations:^{
        cell.layer.opacity = 1.0f;
    }];
}

- (void)showFullDescription:(id)sender {
    NSLog(@"Show the full description...");
}

@end
