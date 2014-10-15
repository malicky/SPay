//
//  OffersViewController.m
//  SPay
//
//  Created by Malick Youla on 2014-10-15.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import "OffersViewController.h"
#import "Reachability.h"
#import "SPWebService.h"
#import "OfferTableCell.h"

@interface OffersViewController ()

@end

@implementation OffersViewController
{
    NSArray *_currentOffers;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self fetchOffers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchOffers
{
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus] == NotReachable) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No internet connection", nil)
                                                         message:NSLocalizedString(@"Internet connection not available.", nil)
                                                        delegate:nil
                                               cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                               otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    UIActivityIndicatorView* v = [[UIActivityIndicatorView alloc]
     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:v];
    v.center = self.view.center;
    [v startAnimating];

    
    NSMutableString *resultString =  [NSMutableString string];
    [resultString appendFormat:@"%@",@"http://api.sponsorpay.com/feed/v1/offers.json?"];
    
    NSString *parameters =  [[SPWebService sharedInstance] paramsStringApiKey:self.apiKey pub0:self.pub0];
    
    [resultString appendFormat:@"%@", parameters];
    
    NSURL *url = [NSURL URLWithString:resultString];
    
    [[SPWebService sharedInstance] fetchAtURL:url withCompletionBlock:^(NSArray *offers) {
        [v removeFromSuperview];

        if (0 == [offers count])
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil)
                                                             message:NSLocalizedString(@"No offers.", nil)
                                                            delegate:nil
                                                   cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                   otherButtonTitles:nil];
            [alert show];
            return;
        }
        NSLog(@"offers count:%lu" ,(unsigned long)[offers count]);
        _currentOffers = offers;
        [self.tableView reloadData];
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_currentOffers)
    {
        return [_currentOffers count];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"offerTableCellIdentifier";
    OfferTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    long section = indexPath.section;
    cell.title.text = _currentOffers[section][@"title"];
    cell.teaser.text = _currentOffers[section][@"teaser"];
    
    NSNumber *payout = _currentOffers[section][@"payout"];
    cell.payout.text = [payout stringValue];

    NSDictionary *thumbnail = _currentOffers[section][@"thumbnail"];
    cell.thumbnailURLString = thumbnail[@"hires"];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
