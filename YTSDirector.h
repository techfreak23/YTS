//
//  YTSDirector.h
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YTSMovie;

@interface YTSDirector : NSManagedObject

@property (nonatomic, retain) NSString * medium_image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * small_image;
@property (nonatomic, retain) YTSMovie *movie;

@end
