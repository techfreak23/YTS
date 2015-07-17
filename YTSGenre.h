//
//  YTSGenre.h
//  YTSFinal
//
//  Created by Art Sevilla on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YTSMovie;

@interface YTSGenre : NSManagedObject

@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) YTSMovie *movie;

@end
