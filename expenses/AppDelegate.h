//
//  AppDelegate.h
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginVC.h"

#define APP_DELEGATE \
((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LoginVC *lvc;
    UINavigationController *navController;
    NSMutableArray *arrayReceiptImages;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) NSMutableArray *arrayReceiptImages;

@end
