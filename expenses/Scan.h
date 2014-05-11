//
//  Scan.h
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ExpenseItemObject.h"

@interface Scan : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UITextFieldDelegate, UITextViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIImagePickerController *imagePickerController;
    UIImageView *imageView;
    BOOL hasImage;
    UIImage *image;
    int expenseItemIndex;
    UITextField *txtExpenseItemName;
    UIButton *btnExpenseSubmissionDate;
    UITextField *txtAmount;
    UITextView *txtDescription;
    
    UIKeyboardType currentKBType;
    UITextField *curTextField;
    
    UIDatePicker *pickerDate;
    UIActionSheet *actionSheet;
    ExpenseItemObject *expenseItemObj;
}

@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *image;
@property(assign) int expenseItemIndex;
@property (nonatomic) UIKeyboardType currentKBType;
@property(nonatomic,strong) UITextField *curTextField;


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;


@end
