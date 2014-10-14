//
//  SPWebService.m
//  SPay
//
//  Created by Malick Youla on 2014-10-13.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import "SPWebService.h"

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
                                         NSLog(@"response: %@", response);

                                     }
                                     // in case of succes, start a background queue for parsing
#if 0
                                     dispatch_queue_t parserQueue = dispatch_queue_create("parserQueue", NULL);
                                     dispatch_async(parserQueue, ^{
                                         
                                         YMiTunesXMLParser *parser = [[YMiTunesXMLParser alloc] init];
                                         
                                         // parse by pages of kPageRecordsCount records for UI responsivness.
                                         NSMutableArray * result = [parser parseData:data batchItemsCount:kPageRecordsCount
                                                                 withCompletionBlock:completionBlock];
                                         if (result && ( [result count] > 0 ) && completionBlock) {
                                             completionBlock (result);
                                         }
                                     });
#endif
                                 }] resume ];
}

@end
