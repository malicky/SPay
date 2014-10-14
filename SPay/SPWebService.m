//
//  SPWebService.m
//  SPay
//
//  Created by Malick Youla on 2014-10-13.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import "SPWebService.h"
#import <AdSupport/AdSupport.h>
#import "NSString+Hashing.h"

@implementation SPWebService

+(instancetype) sharedInstance
{
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

-(instancetype) initUniqueInstance
{
    return [super init];
}

- (void)fetchAtURL:(NSURL *)url withCompletionBlock:(webServiceCompletionHandler)completionBlock {
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url
                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                     if(error) {
                                         NSLog(@"error: %@", error.localizedDescription);
                                         completionBlock(nil);
                                         return ;
                                     }
                                     else
                                     {
                                         if ([(NSHTTPURLResponse*)response statusCode] != 200 )
                                         {
                                             NSLog(@"response error: %@", response);
                                             return;
                                         }
                                     }
                                     
                                     // in case of succes, start a background queue for parsing
                                     dispatch_queue_t parserQueue = dispatch_queue_create("parserQueue", NULL);
                                     dispatch_async(parserQueue, ^{
                                         //parse out the json data
                                         NSError *jsonError = nil;
                                         id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                         if ([result isKindOfClass:[NSDictionary class]])
                                         {
                                             NSArray *offers = result[@"offers"];
                                             if (offers && completionBlock) {
                                                 completionBlock (offers);
                                             }
                                         }
                                         
                                     });
                                     
                                 }] resume ];
}

- (NSString *)paramsString
{
    NSMutableString *parameters =  [NSMutableString string];
    
    NSString *APP_ID = @"2070";
    [parameters appendFormat:@"&appid=%@",APP_ID];
    
    NSString *APPLE_IDFA = @"";
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled])
    {
        APPLE_IDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    [parameters appendFormat:@"&apple_idfa=%@",APPLE_IDFA];
    
    NSString *APPLE_IDFA_TRACKING_ENABLED = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] ? @"true" : @"false";
    [parameters appendFormat:@"&apple_idfa_tracking_enabled=%@",APPLE_IDFA_TRACKING_ENABLED];
    
    NSString *LOCALE = @"en";
    [parameters appendFormat:@"&locale=%@",LOCALE];
    
    NSString *OS_VERSION = [[UIDevice currentDevice] systemVersion];
    [parameters appendFormat:@"&os_version=%@",OS_VERSION];
    
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    [parameters appendFormat:@"&timestamp=%.0f",timeStamp];
    
    NSString *USER_ID = @"spiderman";
    [parameters appendFormat:@"&uid=%@",USER_ID];
    
    NSString *HASH_KEY = [parameters sha1]; //self.apiKeyField.text;
    [parameters appendFormat:@"&hashkey=%@",HASH_KEY];
    
    return parameters;
}
@end
