//
//  YTSTorrent.h
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YTSMovie;

@interface YTSTorrent : NSManagedObject

@property (nonatomic, retain) NSDate * date_uploaded;
@property (nonatomic, retain) NSNumber * download_count;
@property (nonatomic, retain) NSString * framerate;
@property (nonatomic, retain) NSNumber * peers;
@property (nonatomic, retain) NSString * quality;
@property (nonatomic, retain) NSString * resolution;
@property (nonatomic, retain) NSNumber * seeds;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSNumber * size_bytes;
@property (nonatomic, retain) NSString * torrent_hash;
@property (nonatomic, retain) NSString * torrent_url;
@property (nonatomic, retain) YTSMovie *movie;

@end
