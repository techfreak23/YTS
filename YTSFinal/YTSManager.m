//
//  YTSManager.m
//  YTSFinal
//
//  Created by Art Sevilla on 2/18/15.
//  Copyright (c) 2015 Art Sevilla. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "YTSManager.h"

#define kYTSEndpoint @"http://yts.to/api/v2"

typedef void (^RequestCompletion)(id responseItem, NSError *error);

@interface YTSManager();

@property (nonatomic, strong) NSMutableDictionary *userInfo;
@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

dispatch_queue_t kBgQueue;
static NSString *accessToken = @"d0eae475319142a4ad918dc2338527f0";
NSString *userKey;
BOOL isLoggedIn = NO;

//default GET parameters

@implementation YTSManager

+ (YTSManager *)sharedManager
{
    static dispatch_once_t pred;
    static YTSManager *manager = nil;
    
    dispatch_once(&pred, ^{
        manager = [[YTSManager alloc] init];
    });
    
    return  manager;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        kBgQueue = dispatch_queue_create("com.MosRedRocket.GeoChatManager.bgqueue", NULL);
        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kYTSEndpoint]];
        _operationManager.completionQueue = kBgQueue;
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        [_operationManager.requestSerializer setTimeoutInterval:30.0];
        [_operationManager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    }
    
    return self;
}

#pragma mark - Request methods

- (void)sendGETForBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters completion:(RequestCompletion)handler
{
    dispatch_async(kBgQueue, ^{
        self.operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        [self.operationManager GET:baseURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            handler(responseObject, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Did finish GET with error: %@", error.description);
            handler(nil, error);
        }];
    });
}

- (void)sendPOSTForBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters completion:(RequestCompletion)handler
{
    dispatch_async(kBgQueue, ^{
        self.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.operationManager POST:baseURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success message: %@", responseObject);
            handler(responseObject, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"There was an error posting: %@ on operation: %@", error.description, operation.description);
            handler(nil, error);
        }];
    });
}

- (void)sendPATCHRequestForBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters completion:(RequestCompletion)handler
{
    
}

- (void)sendDELETEForBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters completion:(RequestCompletion)handler
{
    
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    NSString *baseUrl = @"user_get_key.json";
    NSDictionary *parameters = @{@"username":username, @"password":password, @"application_key":accessToken};
    
    [self sendPOSTForBaseURL:baseUrl parameters:parameters completion:^(id responseItem, NSError *error) {
        if (!error) {
            if ([self checkStatus:responseItem]) {
                NSLog(@"Login was successful: %@", responseItem);
                isLoggedIn = YES;
                userKey = [NSString stringWithFormat:@"%@", [[responseItem objectForKey:@"data"] objectForKey:@"user_key"]];
                NSLog(@"User key: %@", userKey);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"didLoginSuccessfully" object:nil];
                });
            }
        } else {
            NSLog(@"There was an error logging in...");
            [self postErrorNotification];
        }
    }];
}

- (void)logout
{
    userKey = nil;
    isLoggedIn = NO;
}

- (void)browseMovieListWithLimit:(NSString *)limit page:(NSInteger)page
{
    NSString *baseURL = @"list_movies.json";
    NSString *pageString = [NSString stringWithFormat:@"%li", (long)page];
    NSDictionary *parameters = @{@"limit":limit, @"page":pageString};
    
    [self sendGETForBaseURL:baseURL parameters:parameters completion:^(id responseItem, NSError *error) {
        if (!error) {
            NSString *status = [responseItem objectForKey:@"status"];
            
            if ([status isEqualToString:@"ok"]) {
                NSLog(@"The status is okay");
                NSArray *movies = [[responseItem objectForKey:@"data"] objectForKey:@"movies"];
                NSLog(@"Page number: %@", [[responseItem objectForKey:@"data"] objectForKey:@"page_number"]);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"didFinishFetchingMovieList" object:movies];
                });
                
            } else {
                NSLog(@"The status is NOT okay");
                [self postErrorNotification];
            }
        } else {
            NSLog(@"Browsing movies is not going well...");
            [self postErrorNotification];
        }
    }];
}

- (void)fetchUpcomingList
{
    NSString *baseUrl = @"list_upcoming.json";
    
    [self sendGETForBaseURL:baseUrl parameters:nil completion:^(id responseItem, NSError *error) {
        if (!error) {
            NSArray *upcoming = (NSArray *)[[responseItem objectForKey:@"data"] objectForKey:@"upcoming_movies"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedWithUpcoming" object:upcoming];
            });
        } else {
            NSLog(@"There was an error fetching the upcoming list...");
            [self postErrorNotification];
        }
    }];
}

- (void)fetchMovieDetailsForID:(NSString *)movieID
{
    NSString *baseURL = @"movie_details.json";
    NSDictionary *parameters = @{@"movie_id":movieID, @"with_images": @"true", @"with_cast": @"true"};
    
    [self sendGETForBaseURL:baseURL parameters:parameters completion:^(id responseItem, NSError *error) {
        if (!error) {
            NSDictionary *temp = [NSDictionary dictionaryWithDictionary:(NSDictionary *)responseItem];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didFinishWithMovieDetails" object:[temp objectForKey:@"data"]];
            });
            
        } else {
            [self postErrorNotification];
        }
    }];
}

- (void)postErrorNotification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didFinishWithError" object:nil];
    });
}

- (BOOL)checkStatus:(id)responseItem
{
    NSString *status = [responseItem objectForKey:@"status"];
    
    if ([status isEqualToString:@"ok"]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isLoggedIn
{
    return isLoggedIn;
}

@end
