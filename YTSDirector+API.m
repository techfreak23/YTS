//
//  YTSDirector+API.m
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import "YTSDirector+API.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation YTSDirector (API)

- (YTSDirector *)createDirectorWithInfo:(NSDictionary *)info {
    
    NSString *name = [info objectForKey:@"name"];
    
    YTSDirector *retDirector = [YTSDirector MR_findFirstByAttribute:@"name" withValue:name];
    
    if (retDirector == nil) {
        retDirector = [YTSDirector MR_createEntity];
    }
    
    retDirector.imdb_code = [info objectForKey:@"imdb_code"];
    retDirector.medium_image = [info objectForKey:@"medium_image"];
    retDirector.name = [info objectForKey:@"name"];
    retDirector.small_image = [info objectForKey:@"small_image"];
    
    return retDirector;
}

@end
