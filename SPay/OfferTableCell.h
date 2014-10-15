//
//  OfferTableCell.h
//  SPay
//
//  Created by Malick Youla on 2014-10-15.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thumbnail;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *teaser;
@property (strong, nonatomic) IBOutlet UILabel *payout;
@end
