//
//  ExpenseDetailsVC.m
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "ExpenseDetailsVC.h"
#import "Scan.h"
#import "ExpenseObject.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "Util.h"
#import "ExpenseItemObject.h"
#import "NSData+Base64.h"

@interface ExpenseDetailsVC ()

@end

@implementation ExpenseDetailsVC

@synthesize isSubmitted, currentKBType, curTextField, imagePickerController, isNew, expenseObj, picture;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    expenseTypes = [[NSMutableArray alloc] init];
    dicExpenseTypes = [[NSMutableDictionary alloc]init];
    [self getExpenseTypeList];
    [self CreateControls];
    //[self creatNewExpenses];
    
}

- (void) viewWillAppear:(BOOL)animated;
{
    [self addReceiptCollectionScrollView];
    
    float sum = 0.00;
    
    if([APP_DELEGATE.arrayExpenseItems count] > 0)
    {
        for (int i = 0; i < [APP_DELEGATE.arrayExpenseItems count]; i++)
        {
            ExpenseItemObject *expenseItem = [APP_DELEGATE.arrayExpenseItems objectAtIndex:i];
            sum = sum + [expenseItem.Amount floatValue];
        }
    }
    
    txtAmount.text = [NSString stringWithFormat:@"%.2f", sum];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)CreateControls
{
    self.view.backgroundColor = [UIColor colorWithRed:165/255.0f green:217/255.0f blue:235/255.0f alpha:1.0f];
    
    picture = [[UIImageView alloc] initWithFrame:CGRectMake(15, 70, 90, 90)];
    picture.image = [UIImage imageNamed:@"person.png"];
    [self.view addSubview:picture];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(115, 70, 70, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Name: ";
    [self.view addSubview:label];
    
    lblName = [[UILabel alloc] initWithFrame:CGRectMake(160, 70, 200, 30)];
    lblName.backgroundColor = [UIColor clearColor];
	lblName.font = [UIFont systemFontOfSize:12];
	lblName.textColor = [UIColor blackColor];
	lblName.text = [Util getEmployeeName];
    [self.view addSubview:lblName];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(115, 100, 70, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Email: ";
    [self.view addSubview:label];
    
    lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(160, 100, 200, 30)];
    lblEmail.backgroundColor = [UIColor clearColor];
	lblEmail.font = [UIFont systemFontOfSize:12];
	lblEmail.textColor = [UIColor blackColor];
	lblEmail.text = [Util getUserEmailID];
    [self.view addSubview:lblEmail];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(115, 130, 70, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Phone: ";
    [self.view addSubview:label];
    
    lblPhone = [[UILabel alloc] initWithFrame:CGRectMake(160, 130, 200, 30)];
    lblPhone.backgroundColor = [UIColor clearColor];
	lblPhone.font = [UIFont systemFontOfSize:12];
	lblPhone.textColor = [UIColor blackColor];
	lblPhone.text = [Util getUserPhone];
    [self.view addSubview:lblPhone];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 159, 170, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Expense Submission Date: ";
    [self.view addSubview:label];
    
    btnExpenseSubmissionDate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnExpenseSubmissionDate setFrame:CGRectMake(195, 163, 115, 25)];
    [btnExpenseSubmissionDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnExpenseSubmissionDate.titleLabel.font = [UIFont systemFontOfSize:12];
    [[btnExpenseSubmissionDate layer] setBorderWidth:1.0f];
    [[btnExpenseSubmissionDate layer] setBorderColor:[[UIColor lightGrayColor]CGColor]];
    btnExpenseSubmissionDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnExpenseSubmissionDate setBackgroundImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [btnExpenseSubmissionDate addTarget:self action:@selector(ShowExpenseSubmissionDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnExpenseSubmissionDate];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 185, 180, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Expense Type: ";
    [self.view addSubview:label];
    
    btnTravelType = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnTravelType setFrame:CGRectMake(120, 192, 190, 25)];
    [btnTravelType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnTravelType.titleLabel.font = [UIFont systemFontOfSize:12];
    [[btnTravelType layer] setBorderWidth:1.0f];
    [[btnTravelType layer] setBorderColor:[[UIColor lightGrayColor]CGColor]];
    btnTravelType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnTravelType setBackgroundImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [btnTravelType addTarget:self action:@selector(showTravelTypePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTravelType];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 220, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Client Name: ";
    [self.view addSubview:label];
    
    txtClientName = [[UITextField alloc] initWithFrame:CGRectMake(120, 220, 190, 30)];
	txtClientName.font = [UIFont systemFontOfSize:12];
    txtClientName.tag = 2;
    txtClientName.textColor = [UIColor blackColor];
	txtClientName.borderStyle = UITextBorderStyleLine;
    txtClientName.backgroundColor = [UIColor whiteColor];
    txtClientName.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtClientName.layer.borderWidth= 1.0f;
    [txtClientName addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    txtClientName.keyboardType = UIKeyboardTypeDefault;
    txtClientName.returnKeyType = UIReturnKeyDone;
    txtClientName.AutocorrectionType = UITextAutocorrectionTypeNo;
    txtClientName.delegate = self;
    [self.view addSubview:txtClientName];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 253, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Client Address: ";
    [self.view addSubview:label];
    
    txtClientAddress = [[UITextField alloc] initWithFrame:CGRectMake(120, 253, 190, 30)];
	txtClientAddress.font = [UIFont systemFontOfSize:12];
    txtClientAddress.tag = 2;
    txtClientAddress.textColor = [UIColor blackColor];
	txtClientAddress.borderStyle = UITextBorderStyleLine;
    txtClientAddress.backgroundColor = [UIColor whiteColor];
    txtClientAddress.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtClientAddress.layer.borderWidth= 1.0f;
    [txtClientAddress addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    txtClientAddress.keyboardType = UIKeyboardTypeDefault;
    txtClientAddress.returnKeyType = UIReturnKeyDone;
    txtClientAddress.AutocorrectionType = UITextAutocorrectionTypeNo;
    txtClientAddress.delegate = self;
    [self.view addSubview:txtClientAddress];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 288, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Details: ";
    [self.view addSubview:label];
    
    txtDescription = [[UITextView alloc] initWithFrame:CGRectMake(120, 286, 190, 40)];
    txtDescription.backgroundColor = [UIColor whiteColor];
    txtDescription.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtDescription.layer.borderWidth= 1.0f;
    txtDescription.scrollEnabled = YES;
    txtDescription.pagingEnabled = YES;
    txtDescription.editable = YES;
    txtDescription.delegate = self;
    txtDescription.font = [UIFont systemFontOfSize:12];
    txtDescription.textColor = [UIColor blackColor];
    txtDescription.keyboardType = UIKeyboardTypeDefault;
    txtDescription.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:txtDescription];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 330, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Amount: ";
    [self.view addSubview:label];
    
    txtAmount = [[UITextField alloc] initWithFrame:CGRectMake(120, 330, 190, 30)];
	txtAmount.font = [UIFont systemFontOfSize:12];
    txtAmount.tag = 3;
    txtAmount.textColor = [UIColor blackColor];
	txtAmount.borderStyle = UITextBorderStyleLine;
    txtAmount.backgroundColor = [UIColor whiteColor];
    txtAmount.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtAmount.layer.borderWidth= 1.0f;
    [txtAmount addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    txtAmount.keyboardType = UIKeyboardTypeDecimalPad;
    txtAmount.returnKeyType = UIReturnKeyDone;
    txtAmount.delegate = self;
    [self.view addSubview:txtAmount];
    
    btnUploadInvoice = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnUploadInvoice.frame = CGRectMake(7, 365, 120, 25);
    [btnUploadInvoice setTitle:@"Upload Invoice" forState:UIControlStateNormal];
    [btnUploadInvoice setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnUploadInvoice.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btnUploadInvoice.layer.cornerRadius = 4;
    btnUploadInvoice.layer.borderWidth = 1;
    btnUploadInvoice.layer.borderColor = [UIColor blackColor].CGColor;
    btnUploadInvoice.hidden = TRUE;
    
    receiptCollectionScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, btnUploadInvoice.frame.origin.y + 28, 320, 40)];
    receiptCollectionScrollView.showsVerticalScrollIndicator=YES;
    receiptCollectionScrollView.scrollEnabled=YES;
    receiptCollectionScrollView.userInteractionEnabled=YES;
    [self.view addSubview:receiptCollectionScrollView];
    receiptCollectionScrollView.contentSize = CGSizeMake(320,300);
    
    if(self.expenseObj != nil  && ([expenseObj.Status integerValue] > -1))
    {
        
    }
    else
    {
        CGRect frame, remain;
        CGRectDivide(self.view.bounds, &frame, &remain, 44, CGRectMaxYEdge);
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:frame];
        [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
        
        toolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(submit)],
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)],
                         nil];
        [toolbar sizeToFit];
        toolbar.tintColor = [UIColor whiteColor];
        toolbar.barTintColor = [UIColor colorWithRed:50/255.0f green:134/255.0f blue:221/255.0f alpha:1.0f];//[UIColor colorWithRed:47/255.0f green:177/255.0f blue:241/255.0f alpha:1.0f];
        
        [self.view addSubview:toolbar];
        
        btnUploadInvoice.hidden = FALSE;
        
        //[btnUploadInvoice setImage:[UIImage imageNamed:@"invoice.png"] forState:UIControlStateNormal];
        [btnUploadInvoice addTarget:self action:@selector(showPictureOptions) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnUploadInvoice];
    }
    
    if(self.expenseObj == nil)
    {
        [btnExpenseSubmissionDate setTitle:@"     select date" forState:UIControlStateNormal];
        [btnTravelType setTitle:@"          select travel type" forState:UIControlStateNormal];
        txtClientName.text = @"";
        txtClientName.placeholder = @"enter client name";
        txtClientAddress.text = @"";
        txtClientAddress.placeholder = @"enter client address";
        txtDescription.text = @"";
        txtAmount.text = @"";
        txtAmount.placeholder = @"enter amount";
    }
    else
    {
        NSDate *submissionDate = (NSDate*)expenseObj.ExpenseSubmissionDate;
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"dd-MM-yyyy"];
        [btnExpenseSubmissionDate setTitle:[outputFormatter stringFromDate:submissionDate] forState:UIControlStateNormal];
        
        if(expenseObj.ClientName == nil || [expenseObj.ClientName isEqual:[NSNull null]])
        {
            txtClientName.text = @"";
        }
        else
        {
            txtClientName.text = expenseObj.ClientName;
        }
        
        if(expenseObj.ClientAddress == nil || [expenseObj.ClientAddress isEqual:[NSNull null]])
        {
            txtClientAddress.text = @"";
        }
        else
        {
            txtClientAddress.text = expenseObj.ClientAddress;
        }
        
        if(expenseObj.Notes == nil || [expenseObj.Notes isEqual:[NSNull null]])
        {
            txtDescription.text = @"";
        }
        else
        {
            txtDescription.text = expenseObj.Notes;
        }
        
        if(expenseObj.Amount == nil || [expenseObj.Amount isEqual:[NSNull null]])
        {
            txtAmount.text = @"0.0";
        }
        else
        {
            txtAmount.text = [expenseObj.Amount stringValue];
        }
        
        [self getExpenseItemList];
    }
    
    [self getUserPhoto];
}

-(void)getUserPhoto
{
    NSString *URL = [NSString stringWithFormat:@"%@GetPhoto?PhotoID=%@",BASE_URL, [[Util getUserPhotoId] stringValue]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"responseObject = %@", responseObject);
         
         NSArray *arrayJSON = (NSArray*)[responseObject valueForKeyPath:@"GetPhotoResult"];
         
         for(NSDictionary *obj in arrayJSON)
         {
             NSArray *byteArray = [obj objectForKey:@"AttachmentFile"];
             unsigned c = [byteArray count];
             uint8_t *bytes = malloc(sizeof(*bytes) * c);
             
             unsigned i;
             for (i = 0; i < c; i++)
             {
                 NSString *str = [byteArray objectAtIndex:i];
                 int byte = [str intValue];
                 bytes[i] = (uint8_t)byte;
             }
             
             NSData *data = [[NSData alloc]initWithBytes:bytes length:c];
             UIImage *image = [UIImage imageWithData:data];
             picture.image = image;
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"error %@",error);
         UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }];
}

-(void)getReceiptImage:(ExpenseItemObject*)expenseItem
{
    NSString *URL = [NSString stringWithFormat:@"%@GetAttachment?AttachmentID=%@",BASE_URL, [expenseItem.AttachmentID stringValue]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"receipt image = %@", responseObject);
         
         NSArray *arrayJSON = (NSArray*)[responseObject valueForKeyPath:@"GetAttachmentResult"];
         
         for(NSDictionary *obj in arrayJSON)
         {
             expenseItem.byteFile = [obj objectForKey:@"byteFile"];
             
             NSData *data = [[NSData alloc] initWithData:[NSData dataFromBase64String:expenseItem.byteFile]];
             UIImage *image = [UIImage imageWithData:data];
             
             UIButton *btnPicture = [UIButton buttonWithType:UIButtonTypeCustom];
             btnPicture.tag = [expenseItem.AttachmentID integerValue] - 1;
             [btnPicture setFrame:CGRectMake(btnPicture.tag * 45 , 0, 40, 40)];
             [btnPicture setImage:image forState:UIControlStateNormal];
             [btnPicture addTarget:self action:@selector(showReceiptDetails:) forControlEvents:UIControlEventTouchUpInside];
             [receiptCollectionScrollView addSubview:btnPicture];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"error %@",error);
         UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }];
}

-(void)addReceiptCollectionScrollView
{
    if(receiptCollectionScrollView != nil)
    {
        [receiptCollectionScrollView removeFromSuperview];
        receiptCollectionScrollView = nil;
    }
    
    receiptCollectionScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, btnUploadInvoice.frame.origin.y + 28, 320, 40)];
    receiptCollectionScrollView.showsVerticalScrollIndicator=YES;
    receiptCollectionScrollView.scrollEnabled=YES;
    receiptCollectionScrollView.userInteractionEnabled=YES;
    [self.view addSubview:receiptCollectionScrollView];
    receiptCollectionScrollView.contentSize = CGSizeMake(320,300);
    
    if([APP_DELEGATE.arrayExpenseItems count] > 0)
    {
        for (int i = 0; i < [APP_DELEGATE.arrayExpenseItems count]; i++)
        {
            ExpenseItemObject *expenseItem = [APP_DELEGATE.arrayExpenseItems objectAtIndex:i];
            
            NSData *data = [[NSData alloc] initWithData:[NSData dataFromBase64String:expenseItem.byteFile]];
            UIImage *image = [UIImage imageWithData:data];
            
            UIButton *btnPicture = [UIButton buttonWithType:UIButtonTypeCustom];
            btnPicture.tag = i;
            [btnPicture setFrame:CGRectMake(i * 45 , 0, 40, 40)];
            [btnPicture setImage:image forState:UIControlStateNormal];
            [btnPicture addTarget:self action:@selector(showReceiptDetails:) forControlEvents:UIControlEventTouchUpInside];
            [receiptCollectionScrollView addSubview:btnPicture];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

#pragma mark- Keyboard Delegate
- (void)keyboardWillShowNotification:(NSNotification*)notification{
    
}

- (void)keyboardWillHideNotification:(NSNotification*)notification{
    
}

- (void)TravelTypePickerDoneClick
{
    NSInteger row = [travelTypePickerView selectedRowInComponent:0];
    
    //NSString *itemKey = [expenseTypes objectAtIndex:row];
    //[dicExpenseTypes objectForKey:itemKey];
    
    [btnTravelType setTitle:[expenseTypes objectAtIndex:row] forState:UIControlStateNormal];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)CurrentDateClick
{
    pickerDate.date = [NSDate date];
}

- (void)DatePickerDoneClick
{
   [btnExpenseSubmissionDate setTitle:[Util convertDateToString:pickerDate.date] forState:UIControlStateNormal];
    //txtDOB.text = [outputFormatter stringFromDate:pickerDate.date];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.currentKBType = textField.keyboardType;
    self.curTextField = textField;
    
    if(textField.tag == 1)
    {
        [textField resignFirstResponder];
        [self ShowExpenseSubmissionDatePicker];
        return NO;
    }
    if(textField.tag == 3)
    {
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(textFieldDone:)],
                               nil];
        [numberToolbar sizeToFit];
        numberToolbar.barTintColor = [UIColor clearColor];
        numberToolbar.tintColor = [UIColor colorWithRed:47/255.0f green:177/255.0f blue:241/255.0f alpha:1.0f];
        textField.inputAccessoryView = numberToolbar;
    }
    
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //[textView resignFirstResponder];
    
    return YES;
}

-(void)showPictureOptions
{
    [self.curTextField resignFirstResponder];
    
    actionSheet = [[UIActionSheet alloc]
                   initWithTitle:nil
                   delegate:self
                   cancelButtonTitle:@"Cancel"
                   destructiveButtonTitle:nil
                   otherButtonTitles:@"Choose picture from gallery", @"Take picture from camera", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [actionSheet showInView:self.view ];
    //[actionSheet setBounds:CGRectMake(0,0,320, 200)];
}

-(void) getPhotoFromAlbum
{
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void) getPhotoFromCamera
{
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] || [[device model] isEqualToString:@"iPad"])
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 2;
        [alert show];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            [self getPhotoFromAlbum];
            break;
        }
        case 1:
        {
            [self getPhotoFromCamera];
            break;
        }
    }
}

-(void)showTravelTypePicker
{
    [self.curTextField resignFirstResponder];
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"Travel Type" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    travelTypePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    travelTypePickerView.delegate = self;
    travelTypePickerView.showsSelectionIndicator = YES;
    [self.view addSubview:travelTypePickerView];
    
    UIToolbar *travelTypePickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    travelTypePickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [travelTypePickerToolbar sizeToFit];
    
    travelTypePickerToolbar.barTintColor = [UIColor clearColor];
    travelTypePickerToolbar.tintColor = [UIColor colorWithRed:47/255.0f green:177/255.0f blue:241/255.0f alpha:1.0f];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(TravelTypePickerDoneClick)];
    [barItems addObject:btnCancel];
    
    [travelTypePickerToolbar setItems:barItems animated:YES];
    
    [actionSheet addSubview:travelTypePickerToolbar];
    [actionSheet addSubview:travelTypePickerView];
    actionSheet.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1.0f];//[UIColor whiteColor];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0,0,320, 464)];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
    imagePickerController.view.hidden = YES;
    [self addReceiptCollectionScrollView];
    
    Scan *scan = [[Scan alloc] init];
    scan.title = @"Receipt";
    scan.expenseItemIndex = -1;
    scan.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.navigationController pushViewController:scan animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    // Dismiss the image selection and close the program
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [expenseTypes count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [expenseTypes objectAtIndex:row];
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 300;
}

-(void)ShowExpenseSubmissionDatePicker
{
    [self.curTextField resignFirstResponder];
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"ExpenseSubmissionDate" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    pickerDate = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    pickerDate.maximumDate = [NSDate date];
    if(![Util IsNullOrEmpty:btnExpenseSubmissionDate.titleLabel.text])
    {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        inputFormatter.dateStyle = NSDateFormatterShortStyle;
        [inputFormatter setDateFormat:@"dd-MM-yyyy"];
        NSDate *date = [inputFormatter dateFromString:btnExpenseSubmissionDate.titleLabel.text];
        if(date != nil)
        {
            pickerDate.date = date;
        }
    }
    pickerDate.datePickerMode = UIDatePickerModeDate;
    
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerDateToolbar sizeToFit];
    
    pickerDateToolbar.barTintColor = [UIColor clearColor];
    pickerDateToolbar.tintColor = [UIColor colorWithRed:47/255.0f green:177/255.0f blue:241/255.0f alpha:1.0f];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *btnCurrentDate = [[UIBarButtonItem alloc]initWithTitle:@"Today's Date" style:UIBarButtonItemStyleDone target:self action:@selector(CurrentDateClick)];
    [barItems addObject:btnCurrentDate];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DatePickerDoneClick)];
    [barItems addObject:btnCancel];
    
    [pickerDateToolbar setItems:barItems animated:YES];
    
    [actionSheet addSubview:pickerDateToolbar];
    actionSheet.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1.0f];//[UIColor whiteColor];
    [actionSheet addSubview:pickerDate];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0,0,320, 464)];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}

-(void)save
{
    [self creatNewExpenses];
}

-(void)submit
{
    //[self creatNewExpenses];
    //[self.navigationController popViewControllerAnimated:TRUE];
}

-(void)showReceiptDetails:(id) sender
{
    UIButton *btn = (UIButton *) sender;
    Scan *scan = [[Scan alloc] init];
    scan.title = @"Receipt";
    scan.expenseItemIndex = btn.tag;
    [self.navigationController pushViewController:scan animated:YES];
}

-(void)getExpenseItemList
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:expenseObj.ExpenseID, @"ExpenseID", nil];
    
    NSString *URL = [BASE_URL stringByAppendingString:[NSString stringWithFormat:@"GetExpenseitems"]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
     {
         for (int i = 1; i < 6; i++)
         {
             ExpenseItemObject *expenseItemObj =[[ExpenseItemObject alloc] init];
             
             expenseItemObj.AttachmentID = [NSNumber numberWithInt:i];
             
             [APP_DELEGATE.arrayExpenseItems addObject:expenseItemObj];
             
             [self getReceiptImage:expenseItemObj];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"error %@",error);
         UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }];
}

/*-(void)getExpenseItemList
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[Util getUserId], @"ExpenseChildID",expenseObj.ExpenseID, @"ExpenseID", nil];
    
    NSString *URL = [BASE_URL stringByAppendingString:[NSString stringWithFormat:@"GetExpenseitems"]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"responseObject = %@", responseObject);
         NSArray *arrayJSON = (NSArray*)[responseObject valueForKeyPath:@"GetExpenseitemsResult"];
         
         for(NSDictionary *obj in arrayJSON)
         {
             ExpenseItemObject *expenseItemObj =[[ExpenseItemObject alloc] init];
             
             expenseItemObj.ExpenseID = [obj objectForKey:@"ExpenseID"];
             expenseItemObj.ExpensemasterID = [obj objectForKey:@"ExpensemasterID"];
             expenseItemObj.Expensename = [obj objectForKey:@"ExpenseID"];
             expenseItemObj.Notes = [obj objectForKey:@"Notes"];
             expenseItemObj.ExpenseDate = [obj objectForKey:@"ExpenseID"];
             expenseItemObj.Amount = [obj objectForKey:@"Amount"];
             expenseItemObj.AttachmentID = [obj objectForKey:@"AttachmentID"];
             expenseItemObj.Filename = [obj objectForKey:@"Filename"];
             
             [APP_DELEGATE.arrayExpenseItems addObject:expenseItemObj];
             
             [self getReceiptImage:expenseItemObj];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"error %@",error);
         UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }];
}*/

-(void)getExpenseTypeList
{
    NSString *URL = [BASE_URL stringByAppendingString:[NSString stringWithFormat:@"GetExpensetypes"]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"responseObject = %@", responseObject);
         NSArray *arrayJSON = (NSArray*)[responseObject valueForKeyPath:@"GetExpensetypesResult"];
         //NSLog(@"responseObject = %@", [arrayJSON valueForKey:@"ExpenseID"]);
         
         for(NSDictionary *obj in arrayJSON)
         {
             [expenseTypes addObject:[obj objectForKey:@"CategoryName"]];
             [dicExpenseTypes setObject:[obj objectForKey:@"ExpensetypeID"] forKey:[obj objectForKey:@"CategoryName"]];
         }
         
         if(expenseObj != nil)
         {
             NSArray *temp = [dicExpenseTypes allKeysForObject:expenseObj.ExpensetypeID];
             NSString *key = [temp lastObject];
             
             [btnTravelType setTitle:key forState:UIControlStateNormal];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"error %@",error);
         UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }];
}

-(void)creatNewExpenses
{
    if([btnExpenseSubmissionDate.titleLabel.text isEqualToString:@"     select date"])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"please select submission date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([btnTravelType.titleLabel.text isEqualToString:@"          select travel type"])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"please select expense type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([Util IsNullOrEmpty:txtClientName.text])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"please enter client name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([Util IsNullOrEmpty:txtAmount.text])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"please enter amount" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSDate *submissionDate = [Util convertStringToDate:btnExpenseSubmissionDate.titleLabel.text];
    
    NSNumber *expensetypeID = [dicExpenseTypes objectForKey:btnTravelType.titleLabel.text];
    
    ExpenseObject *expense =[[ExpenseObject alloc] init];
    
    expense.ClientAddress = txtClientAddress.text;
    expense.Amount = [NSNumber numberWithFloat:[txtAmount.text floatValue]];
    expense.ClientName = txtClientName.text;
    expense.EmailID = [Util getUserEmailID];
    expense.EmpID = [Util getUserId];
    expense.EmpName = [Util getUserName];
    expense.ExpenseID = [NSNumber numberWithInt:-1];
    expense.ExpenseSubmissionDate = [Util convertDateToJsonDate:submissionDate];
    expense.ExpensetypeID = expensetypeID;
    expense.ID = [NSNumber numberWithInt:-1];
    //expense.Name = @"jitendrarec";
    expense.Notes = txtDescription.text;
    expense.Status = [NSNumber numberWithInt:-1];
    
    NSURL *baseURL = [NSURL URLWithString:BASE_URL];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:@"CreateUpdateExpense" parameters:[expense toNSDictionary] success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"ExpenseID = %@", responseObject);
            [Util setExpenseId:responseObject];
        /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                            message:@"Expense saved successfully"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];*/
        
        [self creatNewExpenseItem];
        
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
}

-(void)creatNewExpenseItem
{
    NSURL *baseURL = [NSURL URLWithString:BASE_URL];
    //NSURL *baseURL = [NSURL URLWithString:@"http://192.168.1.3:8088/HrmsService.svc/web/"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer = responseSerializer;
    
    
    if([APP_DELEGATE.arrayExpenseItems count] > 0)
    {
        for (int i = 0; i < [APP_DELEGATE.arrayExpenseItems count]; i++)
        {
            ExpenseItemObject *expenseItem = [APP_DELEGATE.arrayExpenseItems objectAtIndex:i];
            expenseItem.ExpenseID = [Util getExpenseId];
    
            [manager POST:@"CreateExpenseItem" parameters:[expenseItem toNSDictionary] success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"ExpenseItemID = %@", responseObject);
                expenseItem.ExpensemasterID = [NSNumber numberWithInt:[responseObject integerValue]];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                    message:@"Expense Item saved successfully"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
                
                [self uploadAttachment:expenseItem];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:[error localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            }];
        }
    }
}

-(void)uploadAttachment:(ExpenseItemObject*) expenseItemObject
{
    NSURL *baseURL = [NSURL URLWithString:BASE_URL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer = responseSerializer;
    
    expenseItemObject.AttachmentID = [NSNumber numberWithInt:-1];
            
    [manager POST:@"CreateExpenseItemAttachment" parameters:[expenseItemObject toNSDictionary] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"AttachmentID = %@", responseObject);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                            message:@"Expense Item saved successfully"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}

- (IBAction)textFieldDone:(id)sender
{
	[self.curTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
