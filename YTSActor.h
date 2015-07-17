//
//  YTSActor.h
//  YTSFinal
//
//  Created by Art Sevilla on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YTSActor : NSManagedObject

@property (nonatomic, retain) NSString * character_name;
@property (nonatomic, retain) NSString * medium_image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * small_image;
@property (nonatomic, retain) NSManagedObject *movie;

@end
