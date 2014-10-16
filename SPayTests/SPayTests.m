//
//  SPayTests.m
//  SPayTests
//
//  Created by Malick Youla on 2014-10-13.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Hashing.h"
#import "SPWebService.h"

@interface SPayTests : XCTestCase

@end

@implementation SPayTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatSHA1Sample
{
    NSString * testString = @"appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de &page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361 &uid=player1&e95a21621a1865bcbae3bee89c4d4f84";
    NSString * sha1String = [testString sha1]; // a709b9b1cf4332b604879a4af04b376e2bfc94d0 as http://www.sha1-online.com
    XCTAssertTrue([sha1String isEqualToString:@"a709b9b1cf4332b604879a4af04b376e2bfc94d0"], @"");
}

- (void)testWSHandlerCalled {
    
    NSMutableString *resultString =  [NSMutableString string];
    [resultString appendFormat:@"%@",@"http://api.sponsorpay.com/feed/v1/offers.json?"];
    NSURL *url = [NSURL URLWithString:resultString];

   XCTestExpectation *expectation = [self expectationWithDescription:@"Handler called"];
    [[SPWebService sharedInstance] fetchAtURL:url withCompletionBlock:^(NSArray *offers) {
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5. handler:nil];

}
@end
