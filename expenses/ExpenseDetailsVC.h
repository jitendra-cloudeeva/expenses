//
//  ExpenseDetailsVC.h
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseDetailsVC : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>
{
    UILabel *lblName;
    UILabel *lblEmail;
    UILabel *lblPhone;
    UITextField *txtClientName;
    UITextField *txtAmount;
    BOOL isSubmitted;
    
    UIKeyboardType currentKBType;
    UITextField *curTextField;
    
    UIDatePicker *pickerDate;
    UIActionSheet *aac;
    NSMutableArray *travelTypes;
    UIButton *btnTravelType;
    UIButton *btnDOB;
    UIPickerView *travelTypePickerView;
}

@property (nonatomic) UIKeyboardType currentKBType;
@property(nonatomic,strong) UITextField *curTextField;
@property(nonatomic,strong) UIButton *doneButton;

@property(nonatomic, assign) BOOL isSubmitted;

@end
