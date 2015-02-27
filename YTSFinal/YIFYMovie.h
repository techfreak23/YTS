//
//  YIFYMovie.h
//  YTS Beta
//
//  Created by Art Sevilla on 10/21/14.
//  Copyright (c) 2014 Art Sevilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YIFYMovie : NSObject

@property (nonatomic, strong) NSString *movieTitle;
@property (nonatomic, strong) NSString *movieCover;
@property (nonatomic, strong) UIImage *coverImage;
@property (nonatomic, strong) NSString *dateAdded;
@property (nonatomic, strong) NSString *movieID;
@property (nonatomic, strong) NSString *movieYear;
@property (nonatomic, strong) NSString *ageRating;
@property (nonatomic, strong) NSString *quality;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *movieRating;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *torrentSeeds;
@property (nonatomic, strong) NSString *torrentPeers;

@end
