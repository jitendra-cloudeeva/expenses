//
//  ExpenseDetailsVC.h
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseDetailsVC : UIViewController<UITextFieldDelegate>
{
    UILabel *lblName;
    UILabel *lblEmail;
    UILabel *lblPhone;
    UITextField *txtClientName;
    UITextField *txtAmount;
    BOOL isSubmitted;
}

@property(nonatomic, assign) BOOL isSubmitted;

@end
