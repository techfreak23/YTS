//
//  TableViewCellFactory.m
//  YTSFinal
//
//  Created by Art Sevilla on 3/12/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import "TableViewCellFactory.h"
#import "ListViewCell.h"
#import "MultiLabelTableViewCell.h"
#import "IVTVTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "CollectionViewTableViewCell.h"

static NSString * const listCellIdentifier = @"listCell";
static NSString * const multiCellIdentifier = @"multiCell";
static NSString * const imageViewCellIdentifier = @"imageViewCell";
static NSString * const textFieldCell = @"textFieldCell";
static NSString * const collectionViewCell = @"cellectionViewCell";

@implementation TableViewCellFactory

+ (instancetype)factory
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView withStyle:(TableViewCellStyle)style forIndexPath:(NSIndexPath *)indexPath
{
    switch (style) {
        case 0:
            return [self listCell:tableView forIndexPath:indexPath];
            break;
            
        case 1:
            return [self multiCell:tableView forIndexPath:indexPath];
            break;
            
        case 2:
             return [self imageCell:tableView forIndexPath:indexPath];
            break;
            
        case 3:
            return [self textFieldCell:tableView forIndexPath:indexPath];
            break;
            
        case 4:
            return [self collectionCell:tableView forIndexPath:indexPath];
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (ListViewCell *)listCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[ListViewCell alloc] init];
    }
    return cell;
}

- (MultiLabelTableViewCell *)multiCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    MultiLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:multiCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MultiLabelTableViewCell alloc] init];
    }
    return cell;
}

- (IVTVTableViewCell *)imageCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    IVTVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageViewCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[IVTVTableViewCell alloc] init];
    }
    return cell;
}

- (TextFieldTableViewCell *)textFieldCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[TextFieldTableViewCell alloc] init];
    }
    return cell;
}

- (CollectionViewTableViewCell *)collectionCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionViewCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[CollectionViewTableViewCell alloc] init];
    }
    return cell;
}

@end
