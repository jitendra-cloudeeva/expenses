//
//  ExpenseDetailsVC.m
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "ExpenseDetailsVC.h"
#import "Scan.h"

@interface ExpenseDetailsVC ()

@end

@implementation ExpenseDetailsVC

@synthesize isSubmitted, currentKBType, curTextField, imagePickerController;

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
}

- (void) viewWillAppear:(BOOL)animated;
{
    [self CreateControls];
}


-(void)CreateControls
{
    self.view.backgroundColor = [UIColor colorWithRed:165/255.0f green:217/255.0f blue:235/255.0f alpha:1.0f];
    
    travelTypes = [[NSMutableArray alloc] init];
    [travelTypes addObject:@"Travel"];
    [travelTypes addObject:@"Food"];
    [travelTypes addObject:@"Ticket"];
    [travelTypes addObject:@"Stationary"];
    [travelTypes addObject:@"Hotel"];
    
    UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(15, 80, 90, 90)];
    picture.image = [UIImage imageNamed:@"jitu.png"];
    [self.view addSubview:picture];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(115, 80, 70, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Name: ";
    [self.view addSubview:label];
    
    lblName = [[UILabel alloc] initWithFrame:CGRectMake(160, 80, 200, 30)];
    lblName.backgroundColor = [UIColor clearColor];
	lblName.font = [UIFont systemFontOfSize:12];
	lblName.textColor = [UIColor blackColor];
	lblName.text = @"Jitendra Rajoria";
    [self.view addSubview:lblName];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(115, 110, 70, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Email: ";
    [self.view addSubview:label];
    
    lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(160, 110, 200, 30)];
    lblEmail.backgroundColor = [UIColor clearColor];
	lblEmail.font = [UIFont systemFontOfSize:12];
	lblEmail.textColor = [UIColor blackColor];
	lblEmail.text = @"jrajoria@cloudeeva.com";
    [self.view addSubview:lblEmail];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(115, 140, 70, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Phone: ";
    [self.view addSubview:label];
    
    lblPhone = [[UILabel alloc] initWithFrame:CGRectMake(160, 140, 200, 30)];
    lblPhone.backgroundColor = [UIColor clearColor];
	lblPhone.font = [UIFont systemFontOfSize:12];
	lblPhone.textColor = [UIColor blackColor];
	lblPhone.text = @" +91-9560888706";
    [self.view addSubview:lblPhone];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 180, 180, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Expense Submission Date: ";
    [self.view addSubview:label];
    
    btnExpenseSubmissionDate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnExpenseSubmissionDate setFrame:CGRectMake(195, 184, 115, 25)];
    [btnExpenseSubmissionDate setTitle:@"         select" forState:UIControlStateNormal];
    [btnExpenseSubmissionDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnExpenseSubmissionDate.titleLabel.font = [UIFont systemFontOfSize:12];
    [[btnExpenseSubmissionDate layer] setBorderWidth:1.0f];
    [[btnExpenseSubmissionDate layer] setBorderColor:[[UIColor lightGrayColor]CGColor]];
    btnExpenseSubmissionDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnExpenseSubmissionDate setBackgroundImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [btnExpenseSubmissionDate addTarget:self action:@selector(ShowExpenseSubmissionDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnExpenseSubmissionDate];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 210, 180, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Expense Type: ";
    [self.view addSubview:label];
    
    btnTravelType = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnTravelType setFrame:CGRectMake(120, 213, 190, 25)];
    [btnTravelType setTitle:@"          select travel type" forState:UIControlStateNormal];
    [btnTravelType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnTravelType.titleLabel.font = [UIFont systemFontOfSize:12];
    [[btnTravelType layer] setBorderWidth:1.0f];
    [[btnTravelType layer] setBorderColor:[[UIColor lightGrayColor]CGColor]];
    btnTravelType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnTravelType setBackgroundImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [btnTravelType addTarget:self action:@selector(showTravelTypePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTravelType];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 240, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Client Name: ";
    [self.view addSubview:label];
    
    txtClientName = [[UITextField alloc] initWithFrame:CGRectMake(120, 240, 190, 30)];
	txtClientName.font = [UIFont systemFontOfSize:12];
    txtClientName.tag = 2;
    txtClientName.text = @"Cloudeeva Inc.";
    txtClientName.textColor = [UIColor blackColor];
	txtClientName.borderStyle = UITextBorderStyleLine;
    txtClientName.backgroundColor = [UIColor whiteColor];
    txtClientName.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtClientName.layer.borderWidth= 1.0f;
    [txtClientName addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    txtClientName.keyboardType = UIKeyboardTypeDefault;
    txtClientName.returnKeyType = UIReturnKeyDone;
    txtClientName.delegate = self;
    [self.view addSubview:txtClientName];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 270, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Details: ";
    [self.view addSubview:label];
    
    UITextView *description = [[UITextView alloc] initWithFrame:CGRectMake(120, 275, 190, 50)];
    description.backgroundColor = [UIColor whiteColor];
    description.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    description.layer.borderWidth= 1.0f;
    description.text = @"Cloudeeva Inc.";
    description.scrollEnabled = YES;
    description.pagingEnabled = YES;
    description.editable = YES;
    description.delegate = self;
    description.font = [UIFont systemFontOfSize:12];
    description.textColor = [UIColor blackColor];
    description.keyboardType = UIKeyboardTypeDefault;
    description.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:description];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 330, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Amount: ";
    [self.view addSubview:label];
    
    txtAmount = [[UITextField alloc] initWithFrame:CGRectMake(120, 330, 190, 30)];
	txtAmount.font = [UIFont systemFontOfSize:12];
    txtAmount.tag = 3;
    txtAmount.text = @"10,000";
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
    [btnUploadInvoice setTitle:@"Invoice Image" forState:UIControlStateNormal];
    [btnUploadInvoice setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnUploadInvoice.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    btnUploadInvoice.layer.cornerRadius = 4;
    btnUploadInvoice.layer.borderWidth = 1;
    btnUploadInvoice.layer.borderColor = [UIColor blackColor].CGColor;
    
    //[btnUploadInvoice setImage:[UIImage imageNamed:@"invoice.png"] forState:UIControlStateNormal];
    [btnUploadInvoice addTarget:self action:@selector(showPictureOptions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnUploadInvoice];
    
    [self addReceiptCollectionScrollView];
    
    if(!isSubmitted)
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
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
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
    
    if([APP_DELEGATE.arrayReceiptImages count] > 0)
    {
        for (int i = 0; i < [APP_DELEGATE.arrayReceiptImages count]; i++)
        {
            UIButton *btnPicture = [UIButton buttonWithType:UIButtonTypeCustom];
            btnPicture.tag = i;
            [btnPicture setFrame:CGRectMake(i * 45 , 0, 40, 40)];
            [btnPicture setImage:[APP_DELEGATE.arrayReceiptImages objectAtIndex:i] forState:UIControlStateNormal];
            [btnPicture addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
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
    [btnTravelType setTitle:[travelTypes objectAtIndex:row] forState:UIControlStateNormal];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)CurrentDateClick
{
    pickerDate.date = [NSDate date];
}

- (void)DatePickerDoneClick
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd-MM-yyyy"];
    [btnExpenseSubmissionDate setTitle:[outputFormatter stringFromDate:pickerDate.date] forState:UIControlStateNormal];
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
    [textView resignFirstResponder];
    
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
        alert.tag = 1;
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
    actionSheet.backgroundColor = [UIColor whiteColor];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0,0,320, 464)];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
    imagePickerController.view.hidden = YES;
    [APP_DELEGATE.arrayReceiptImages addObject:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    [self addReceiptCollectionScrollView];
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
    
    
    return [travelTypes count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [travelTypes objectAtIndex:row];
    
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
    if(![APP_DELEGATE IsNullOrEmpty:btnExpenseSubmissionDate.titleLabel.text])
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
    actionSheet.backgroundColor = [UIColor whiteColor];
    [actionSheet addSubview:pickerDate];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0,0,320, 464)];
}

-(void)save
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Success" message:@"Expense details saved successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)submit
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)showImage:(id) sender
{
    UIButton *btn = (UIButton *) sender;
    Scan *scan = [[Scan alloc] init];
    scan.title = @"Receipt";
    scan.image = btn.imageView.image;
    scan.imageButtonIndex = btn.tag;
    [self.navigationController pushViewController:scan animated:YES];
}

-(void)uploadInvoice
{
    Scan *scan = [[Scan alloc] init];
    scan.title = @"Receipt";
    scan.image = nil;
    [self.navigationController pushViewController:scan animated:YES];
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
