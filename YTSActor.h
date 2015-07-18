//
//  YTSActor.h
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YTSMovie;

@interface YTSActor : NSManagedObject

@property (nonatomic, retain) NSString * character_name;
@property (nonatomic, retain) NSString * imdb_code;
@property (nonatomic, retain) NSString * medium_image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * small_image;
@property (nonatomic, retain) YTSMovie * movie;

@end
