//
//  TableViewCellFactory.h
//  YTSFinal
//
//  Created by Art Sevilla on 3/12/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/*
typedef enum {
    List = 0,
    Multi,
    ImageCell,
    TextField,
    CollectionCell
    
} TableViewCellStyle;
 */

typedef NS_ENUM(int, TableViewCellStyle) {
    TableViewCellStyleList,
    TableViewCellStyleMulti,
    TableViewCellStyleImageCell,
    TableViewCellStyleTextField,
    TableViewCellStyleCollectionView
};

@interface TableViewCellFactory : NSObject

+ (instancetype)factory;

- (UITableViewCell *)tableView:(UITableView *)tableView withStyle:(TableViewCellStyle)style forIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)createCellForTableView:(UITableView *)tableView style:(TableViewCellStyle)style indexPath:(NSIndexPath *)indexPath

@end
