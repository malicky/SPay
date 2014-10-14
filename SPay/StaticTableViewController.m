//
//  StaticTableViewController.m
//  SPay
//
//  Created by Malick Youla on 2014-10-13.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import "StaticTableViewController.h"
#import "Reachability.h"
#import "SPWebService.h"
#import <AdSupport/AdSupport.h>
#import "NSString+Hashing.h"

@interface StaticTableViewController ()

@end

@implementation StaticTableViewController
{
    NSString *_advertiseId;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)checkYesButton
{
    self.yesButton.enabled = NO;
    self.yesButton.enabled =
    (self.uidField.text.length != 0) &&
    (self.apiKeyField.text.length != 0) &&
    (self.appIdField.text.length != 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self checkYesButton];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) textField:(UITextField *)aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Check
    
    [self checkYesButton];

    return YES;
}



- (IBAction)yesAction:(id)sender {
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus] == NotReachable) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No internet connection", nil)
                                                         message:NSLocalizedString(@"Internet connection not available.", nil)
                                                        delegate:nil
                                               cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                               otherButtonTitles:nil];
        [alert show];
        return;
    }

    NSMutableString *resultString =  [NSMutableString string];
    [resultString appendFormat:@"%@",@"http://api.sponsorpay.com/feed/v1/offers.json?"];

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
    
    
    [resultString appendFormat:@"%@", parameters];

    NSURL *url = [NSURL URLWithString:resultString];

    [[SPWebService sharedInstance] fetchAtURL:url withCompletionBlock:^(NSMutableArray *records) {
        
    }];
    

}

- (IBAction)noAction:(id)sender {
    [self.view endEditing:YES];
}
@end
