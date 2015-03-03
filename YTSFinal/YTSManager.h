//
//  YTSManager.h
//  YTSFinal
//
//  Created by Art Sevilla on 2/18/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTSManager : NSObject

+ (YTSManager *)sharedManager;

- (BOOL)isLoggedIn;
- (void)fetchUpcomingList;
- (void)browseMovieListWithLimit:(NSString *)limit page:(NSInteger)page;
- (void)fetchMovieDetailsForID:(NSString *)movieID;
- (void)loginWithUsername:(NSString *)username password:(NSString *)password;

@end
