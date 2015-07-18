//
//  YTSMovie+API.m
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import "YTSMovie+API.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation YTSMovie (API)

- (YTSMovie *)createMovieObjectWithInfo:(NSDictionary *)info {
    
    NSString *movieID = [info objectForKey:@"id"];
    
    YTSMovie *retMovie = [YTSMovie MR_findFirstByAttribute:@"movie_id" withValue:movieID];
    
    if (retMovie == nil) {
        retMovie = [YTSMovie MR_createEntity];
    }
    
    
    
    return retMovie;
}

@end
