//
//  YTSListMovie+API.m
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import "YTSListMovie+API.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation YTSListMovie (API)

- (YTSListMovie *)createListMovieWithInfo:(NSDictionary *)info {
    NSString *movieID = [info objectForKey:@"id"];
    
    YTSListMovie *retMovie = [YTSListMovie MR_findFirstByAttribute:@"movie" withValue:movieID];
    
    if (retMovie == nil) {
        retMovie = [YTSListMovie MR_createEntity];
    }
    
    retMovie.background_image_url = [info objectForKey:@"background_image"];
    
    NSString *date = [info objectForKey:@"date_uploaded"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    NSDate *dateUploaded = [format dateFromString:date];
    
    retMovie.date_uploaded = dateUploaded;
    retMovie.imdb_code = [info objectForKey:@"imdb_code"];
    retMovie.language = [info objectForKey:@"language"];
    retMovie.medium_cover_image_url = [info objectForKey:@"medium_image_cover"];
    retMovie.movie_id = [info objectForKey:@"id"];
    retMovie.movie_url = [info objectForKey:@"url"];
    retMovie.mpa_rating = [info objectForKey:@"mpa_rating"];
    retMovie.rating = [NSString stringWithFormat:@"%@", [info objectForKey:@"rating"]];
    retMovie.runtime = [NSString stringWithFormat:@"%@", [info objectForKey:@"runtime"]];
    retMovie.slug = [info objectForKey:@"slug"];
    retMovie.small_cover_image_url = [info objectForKey:@"small_image_cover"];
    retMovie.state = [info objectForKey:@"state"];
    retMovie.title = [info objectForKey:@"title"];
    retMovie.title_long = [info objectForKey:@"title_long"];
    retMovie.year = [NSString stringWithFormat:@"%@", [info objectForKey:@"year"]];
    
    return retMovie;
}

@end
