//
//  SPWebService.h
//  SPay
//
//  Created by Malick Youla on 2014-10-13.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^webServiceCompletionHandler) (NSMutableArray *records);

@interface SPWebService : NSObject
+ (instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
+ (instancetype) sharedInstance;
- (void)fetchAtURL:(NSURL *)url withCompletionBlock:(webServiceCompletionHandler)completionBlock;

@end