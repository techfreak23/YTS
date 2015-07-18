//
//  YTSActor+API.m
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import "YTSActor+API.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation YTSActor (API)

- (YTSActor *)createActorWithInfo:(NSDictionary *)info {
    
    NSString *name = [info objectForKey:@"character_name"];
    
    YTSActor *retActor = [YTSActor MR_findFirstByAttribute:@"character_name" withValue:name];
    
    if (retActor == nil) {
        retActor = [YTSActor MR_createEntity];
    }
    
    retActor.character_name = name;
    retActor.imdb_code = [info objectForKey:@"imdb_code"];
    retActor.name = [info objectForKey:@"name"];
    retActor.medium_image = [info objectForKey:@"medium_image"];
    retActor.small_image = [info objectForKey:@"small_image"];
    
    return retActor;
}

@end
