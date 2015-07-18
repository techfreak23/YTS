//
//  YTSMovie+API.m
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import "YTSMovie+API.h"
#import "YTSActor+API.h"
#import "YTSDirector+API.h"
#import "YTSTorrent+API.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation YTSMovie (API)

- (YTSMovie *)createMovieObjectWithInfo:(NSDictionary *)info {
    
    NSString *movieID = [info objectForKey:@"id"];
    
    YTSMovie *retMovie = [YTSMovie MR_findFirstByAttribute:@"movie_id" withValue:movieID];
    
    if (retMovie == nil) {
        retMovie = [YTSMovie MR_createEntity];
    }
    
    NSString *date = [info objectForKey:@"date_uploaded"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    NSDate *dateUploaded = [format dateFromString:date];
    
    retMovie.date_uploaded = dateUploaded;
    retMovie.description_full = [info objectForKey:@"description_full"];
    retMovie.description_intro = [info objectForKey:@"description_intro"];
    
    NSString *downloadCount = [info objectForKey:@"download_count"];
    
    retMovie.download_count = [NSNumber numberWithInt:downloadCount.intValue];
    retMovie.images = [info objectForKey:@"images"];
    retMovie.imdb_code = [info objectForKey:@"imdb_code"];
    retMovie.language = [info objectForKey:@"language"];
    
    NSString *likeCount = [info objectForKey:@"like_count"];
    
    retMovie.like_count = [NSNumber numberWithInt:likeCount.intValue];
    retMovie.movie_id = [NSString stringWithFormat:@"%@", [info objectForKey:@"id"]];
    retMovie.movie_url = [info objectForKey:@"url"];
    retMovie.mpa_rating = [info objectForKey:@"mpa_rating"];
    retMovie.rating = [NSString stringWithFormat:@"%@", [info objectForKey:@"rating"]];
    retMovie.rt_audience_rating = [info objectForKey:@"rt_audience_rating"];
    retMovie.rt_critics_rating = [info objectForKey:@"rt_critics_rating"];
    
    NSString *audienceScore = [info objectForKey:@"rt_audience_score"];
    NSString *criticScore = [info objectForKey:@"rt_critics_score"];
    
    retMovie.rt_audience_score = [NSNumber numberWithInt:audienceScore.intValue];
    retMovie.rt_critics_score = [NSNumber numberWithInt:criticScore.intValue];
    retMovie.runtime = [info objectForKey:@"runtime"];
    retMovie.slug = [info objectForKey:@"slug"];
    retMovie.title = [info objectForKey:@"title"];
    retMovie.title_long = [info objectForKey:@"title_long"];
    retMovie.year = [NSString stringWithFormat:@"%@", [info objectForKey:@"year"]];
    retMovie.yt_trailer_code = [info objectForKey:@"yt_trailer_code"];
    
    NSArray *actors = [info objectForKey:@"actors"];
    
    for (NSDictionary *tempDict in actors) {
        YTSActor *actor = [[YTSActor alloc] createActorWithInfo:tempDict];
        actor.movie = self;
        [retMovie addActorsObject:actor];
    }
    
    NSArray *directors = [info objectForKey:@"directors"];
    
    for (NSDictionary *tempDict in directors) {
        YTSDirector *director = [[YTSDirector alloc] createDirectorWithInfo:tempDict];
        director.movie = self;
        [retMovie addDirectorsObject:director];
    }
    
    NSArray *torrents = [info objectForKey:@"torrents"];
    
    for (NSDictionary *tempDict in torrents) {
        YTSTorrent *torrent = [[YTSTorrent alloc] createTorrentWithInfo:tempDict];
        torrent.movie = self;
        [retMovie addTorrentsObject:torrent];
    }
    
    return retMovie;
}

@end
