//
//  AppDelegate.h
//  SPay
//
//  Created by Malick Youla on 2014-10-13.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPWebService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) SPWebService *webservice;

@end
