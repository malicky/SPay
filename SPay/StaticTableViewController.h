//
//  StaticTableViewController.h
//  SPay
//
//  Created by Malick Youla on 2014-10-13.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *uidField;
@property (strong, nonatomic) IBOutlet UITextField *apiKeyField;
@property (strong, nonatomic) IBOutlet UITextField *appIdField;
@property (strong, nonatomic) IBOutlet UITextField *pubOField;
@property (strong, nonatomic) IBOutlet UIButton *yesButton;
@property (strong, nonatomic) IBOutlet UIButton *noButton;
- (IBAction)yesAction:(id)sender;
- (IBAction)noAction:(id)sender;

@end
