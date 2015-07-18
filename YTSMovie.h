//
//  YTSMovie.h
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YTSActor, YTSDirector, YTSGenre, YTSTorrent;

@interface YTSMovie : NSManagedObject

@property (nonatomic, retain) NSDate * date_uploaded;
@property (nonatomic, retain) NSString * description_full;
@property (nonatomic, retain) NSString * description_intro;
@property (nonatomic, retain) NSNumber * download_count;
@property (nonatomic, retain) id images;
@property (nonatomic, retain) NSString * imdb_code;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSNumber * like_count;
@property (nonatomic, retain) NSString * movie_id;
@property (nonatomic, retain) NSString * movie_url;
@property (nonatomic, retain) NSString * mpa_rating;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * rt_audience_rating;
@property (nonatomic, retain) NSNumber * rt_audience_score;
@property (nonatomic, retain) NSString * rt_critics_rating;
@property (nonatomic, retain) NSNumber * rt_critics_score;
@property (nonatomic, retain) NSString * runtime;
@property (nonatomic, retain) NSString * slug;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * title_long;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * yt_trailer_code;
@property (nonatomic, retain) NSSet *actors;
@property (nonatomic, retain) NSSet *directors;
@property (nonatomic, retain) NSSet *torrents;
@end

@interface YTSMovie (CoreDataGeneratedAccessors)

- (void)addActorsObject:(YTSActor *)value;
- (void)removeActorsObject:(YTSActor *)value;
- (void)addActors:(NSSet *)values;
- (void)removeActors:(NSSet *)values;

- (void)addDirectorsObject:(YTSDirector *)value;
- (void)removeDirectorsObject:(YTSDirector *)value;
- (void)addDirectors:(NSSet *)values;
- (void)removeDirectors:(NSSet *)values;

- (void)addTorrentsObject:(YTSTorrent *)value;
- (void)removeTorrentsObject:(YTSTorrent *)value;
- (void)addTorrents:(NSSet *)values;
- (void)removeTorrents:(NSSet *)values;

@end
