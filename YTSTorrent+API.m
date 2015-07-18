//
//  YTSTorrent+API.m
//  YTSFinal
//
//  Created by Mac Demo on 7/17/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import "YTSTorrent+API.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation YTSTorrent (API)

- (YTSTorrent *)createTorrentWithInfo:(NSDictionary *)info {
    NSString *torrentHash = [info objectForKey:@"hash"];
    
    YTSTorrent *retTorrent = [YTSTorrent MR_findFirstByAttribute:@"hash" withValue:torrentHash];
    
    if (retTorrent == nil) {
        retTorrent = [YTSTorrent MR_createEntity];
    }
    
    NSString *date = [info objectForKey:@"date_uploaded"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    NSDate *dateUploaded = [format dateFromString:date];
    
    retTorrent.date_uploaded = dateUploaded;
    
    NSString *downloadCount = [info objectForKey:@"download_count"];
    
    retTorrent.download_count = [NSNumber numberWithInt:downloadCount.intValue];
    retTorrent.framerate = [NSString stringWithFormat:@"%@", [info objectForKey:@"framerate"]];
    
    NSString *peers = [info objectForKey:@"peers"];
    NSString *seeds = [info objectForKey:@"seeds"];
    NSString *sizeBytes = [info objectForKey:@"size_bytes"];
    
    retTorrent.peers = [NSNumber numberWithInt:peers.intValue];
    retTorrent.seeds = [NSNumber numberWithInt:seeds.intValue];
    retTorrent.size_bytes = [NSNumber numberWithInt:sizeBytes.intValue];
    retTorrent.quality = [info objectForKey:@"quality"];
    retTorrent.resolution = [info objectForKey:@"resolution"];
    retTorrent.size = [info objectForKey:@"size"];
    retTorrent.torrent_hash = [info objectForKey:@"hash"];
    retTorrent.torrent_url = [info objectForKey:@"url"];
    
    return retTorrent;
}

@end
