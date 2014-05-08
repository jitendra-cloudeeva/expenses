//
//  LoginVC.h
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginVC : UIViewController<UITextFieldDelegate>
{
    UITextField *txtUsername;
    UITextField *txtPassword;
    UIButton *btnLogin;
}

@end
