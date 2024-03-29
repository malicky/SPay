//
//  StaticTableViewController.m
//  SPay
//
//  Created by Malick Youla on 2014-10-13.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import "StaticTableViewController.h"
#import "OffersViewController.h"

@interface StaticTableViewController ()

@end

@implementation StaticTableViewController
{
    NSString *_advertiseId;
    NSArray *_currentOffers;
    OffersViewController *_segueDestinationViewController;
    NSString *_segueIdentifier;
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


- (IBAction)noAction:(id)sender {
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"source controller = %@", [segue sourceViewController]);
    NSLog(@"destination controller = %@", [segue destinationViewController]);
    NSLog(@"segue identifier = %@", [segue identifier   ]);
    
    
    if ([[segue identifier] isEqualToString:@"showOffers"]) {
        _segueDestinationViewController = [segue destinationViewController];
        _segueDestinationViewController.apiKey = self.apiKeyField.text;
        _segueDestinationViewController.pub0 = self.pubOField.text;
        _segueIdentifier = [segue identifier];
    }
}
@end
