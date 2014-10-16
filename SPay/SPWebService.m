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
                                             completionBlock(nil);
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

- (NSString *)paramsStringApiKey:(NSString *)apiKey pub0:(NSString *)pub0
{
    NSMutableString *parameters =  [NSMutableString string];

    
    NSString *APP_ID = @"2070";
    [parameters appendFormat:@"appid=%@",APP_ID];
    [parameters appendFormat:@"&offer_types=%@",@"112"];

    if (![pub0 isEqualToString:@""]) {
        [parameters appendFormat:@"&pub0=%@",pub0];
    }
    
    const NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    [parameters appendFormat:@"&timestamp=%.0f",timeStamp];

    NSString *USER_ID = @"spiderman";
    [parameters appendFormat:@"&uid=%@",USER_ID];
    
    [parameters appendFormat:@"&%@",apiKey];

    NSString *HASH_KEY = [parameters sha1];
    
    // now
    parameters = [@"" mutableCopy];
    [parameters appendFormat:@"&appid=%@",APP_ID];
    [parameters appendFormat:@"&offer_types=%@",@"112"];

    if (![pub0 isEqualToString:@""]) {
        [parameters appendFormat:@"&pub0=%@",pub0];
    }
    [parameters appendFormat:@"&timestamp=%.0f",timeStamp];
    [parameters appendFormat:@"&uid=%@",USER_ID];
   // [parameters appendFormat:@"&%@",apiKey];
    [parameters appendFormat:@"&hashkey=%@",HASH_KEY];
    
    NSString * testString = @"appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de &page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361 &uid=player1&e95a21621a1865bcbae3bee89c4d4f84";
    NSString * __unused sha1String = [testString sha1]; // a709b9b1cf4332b604879a4af04b376e2bfc94d0 as http://www.sha1-online.com

    
    return parameters;
}
@end
