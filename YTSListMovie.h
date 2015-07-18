//
//  YTSListMovie.h
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YTSListMovie : NSManagedObject

@property (nonatomic, retain) NSString * background_image_url;
@property (nonatomic, retain) NSDate * date_uploaded;
@property (nonatomic, retain) NSString * imdb_code;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * medium_cover_image_url;
@property (nonatomic, retain) NSString * movie_id;
@property (nonatomic, retain) NSString * movie_url;
@property (nonatomic, retain) NSString * mpa_rating;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * runtime;
@property (nonatomic, retain) NSString * slug;
@property (nonatomic, retain) NSString * small_cover_image_url;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * title_long;
@property (nonatomic, retain) NSString * year;

@end
