//
//  Scan.h
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Scan : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UITextFieldDelegate>
{
    UIImagePickerController *imagePickerController;
    UIImageView *imageView;
    BOOL hasImage;
    UIImage *image;
    int imageButtonIndex;
    UITextField *txtExpenseItemName;
    UIButton *btnExpenseSubmissionDate;
    UITextField *txtAmount;
    UITextView *txtDescription;
}

@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *image;
@property(assign) int imageButtonIndex;

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;


@end
