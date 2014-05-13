//
//  ExpenseDetailsVC.h
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpenseObject.h"
#import <MessageUI/MessageUI.h>

@interface ExpenseDetailsVC : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate,UIImagePickerControllerDelegate, UIAlertViewDelegate,UINavigationControllerDelegate,UITextViewDelegate,NSURLSessionTaskDelegate,MFMailComposeViewControllerDelegate>
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
    UIActionSheet *actionSheet;
    NSMutableArray *expenseTypes;
    NSMutableDictionary *dicExpenseTypes;
    UIButton *btnTravelType;
    UIButton *btnExpenseSubmissionDate;
    UIPickerView *travelTypePickerView;
    UIButton *btnUploadInvoice;
    UITextView *txtDescription;
    
    UIImagePickerController *imagePickerController;
    
    UIScrollView *receiptCollectionScrollView;
    
    BOOL isNew;
    
    ExpenseObject *expenseObj;
    UIImageView *picture;
    UITextField *txtClientAddress;
    
    MFMailComposeViewController *mailComposer;
    
    UIButton *btnEmail;
    UIButton *btnPhone;
    CGFloat animatedDistance;
}
@property (nonatomic, strong) NSURLSessionUploadTask *uploadTask;
@property (nonatomic) UIKeyboardType currentKBType;
@property(nonatomic,strong) UITextField *curTextField;
@property(nonatomic,strong) UIButton *doneButton;

@property(nonatomic, assign) BOOL isSubmitted;
@property(nonatomic, assign) BOOL isNew;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property (nonatomic, strong) ExpenseObject *expenseObj;
@property (nonatomic, strong) UIImageView *picture;;

@end
