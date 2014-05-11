//
//  Scan.m
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "Scan.h"
#import "AppDelegate.h"
#import "Util.h"
#import "ExpenseItemObject.h"
#import "NSData+Base64.h"

@implementation Scan
@synthesize imagePickerController, imageView, image, expenseItemIndex,currentKBType, curTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    hasImage = FALSE;
    
    self.view.backgroundColor = [UIColor colorWithRed:165/255.0f green:217/255.0f blue:235/255.0f alpha:1.0f];
    
    UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadImage)];
    self.navigationItem.rightBarButtonItem = itemright;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Expense Item Name: ";
    [self.view addSubview:label];
    
    txtExpenseItemName = [[UITextField alloc] initWithFrame:CGRectMake(147, 70, 160, 25)];
	txtExpenseItemName.font = [UIFont systemFontOfSize:12];
    txtExpenseItemName.tag = 1;
    txtExpenseItemName.textColor = [UIColor blackColor];
	txtExpenseItemName.borderStyle = UITextBorderStyleLine;
    txtExpenseItemName.backgroundColor = [UIColor whiteColor];
    txtExpenseItemName.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtExpenseItemName.layer.borderWidth= 1.0f;
    [txtExpenseItemName addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    txtExpenseItemName.keyboardType = UIKeyboardTypeDefault;
    txtExpenseItemName.returnKeyType = UIReturnKeyDone;
    txtExpenseItemName.AutocorrectionType = UITextAutocorrectionTypeNo;
    txtExpenseItemName.delegate = self;
    [self.view addSubview:txtExpenseItemName];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 170, 25)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Expense Submission Date: ";
    [self.view addSubview:label];
    
    btnExpenseSubmissionDate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnExpenseSubmissionDate setFrame:CGRectMake(185, 100, 122, 25)];
    
    [btnExpenseSubmissionDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnExpenseSubmissionDate.titleLabel.font = [UIFont systemFontOfSize:12];
    [[btnExpenseSubmissionDate layer] setBorderWidth:1.0f];
    [[btnExpenseSubmissionDate layer] setBorderColor:[[UIColor lightGrayColor]CGColor]];
    btnExpenseSubmissionDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnExpenseSubmissionDate setBackgroundImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [btnExpenseSubmissionDate addTarget:self action:@selector(ShowExpenseSubmissionDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnExpenseSubmissionDate];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 130, 140, 25)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Amount: ";
    [self.view addSubview:label];
    
    txtAmount = [[UITextField alloc] initWithFrame:CGRectMake(72, 130, 235, 25)];
	txtAmount.font = [UIFont systemFontOfSize:12];
    txtAmount.tag = 2;
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
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.textColor = [UIColor blackColor];
	label.text = @"Details: ";
    [self.view addSubview:label];
    
    txtDescription = [[UITextView alloc] initWithFrame:CGRectMake(72, 160, 235, 40)];
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
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 210, 300, 260)];
    imageView.image = [UIImage imageNamed:@"NoImage.png"];
    [self.view addSubview:imageView];
    
    CGRect frame, remain;
    CGRectDivide(self.view.bounds, &frame, &remain, 44, CGRectMaxYEdge);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:frame];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    
    
    [toolbar sizeToFit];
    toolbar.tintColor = [UIColor whiteColor];
    toolbar.barTintColor = [UIColor colorWithRed:50/255.0f green:134/255.0f blue:221/255.0f alpha:1.0f];//[UIColor colorWithRed:47/255.0f green:177/255.0f blue:241/255.0f alpha:1.0f];
    
    //[self.view addSubview:toolbar];
    
    imageView.image = image;
    
    if(expenseItemIndex > -1)
    {
        if([expenseItemObj.AttachmentID integerValue] > -1)
        {
            UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithTitle:@"Remove" style:UIBarButtonItemStylePlain target:self action:@selector(RemoveImage)];
            self.navigationItem.rightBarButtonItem = itemright;
        }
        
        expenseItemObj = [APP_DELEGATE.arrayExpenseItems objectAtIndex:expenseItemIndex];
        
        if(expenseItemObj.Expensename == nil || [expenseItemObj.Expensename isEqual:[NSNull null]])
        {
            txtExpenseItemName.text = @"";
        }
        else
        {
            txtExpenseItemName.text = expenseItemObj.Expensename;
        }
        
        NSDate *submissionDate = [Util dateFromDotNet:expenseItemObj.ExpenseDate];
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"dd-MM-yyyy"];
        [btnExpenseSubmissionDate setTitle:[outputFormatter stringFromDate:submissionDate] forState:UIControlStateNormal];
        
        if(expenseItemObj.Amount == nil || [expenseItemObj.Amount isEqual:[NSNull null]])
        {
            txtAmount.text = @"0.0";
        }
        else
        {
            txtAmount.text = [expenseItemObj.Amount stringValue];
        }
        if(expenseItemObj.Notes == nil || [expenseItemObj.Notes isEqual:[NSNull null]])
        {
            txtDescription.text = @"";
        }
        else
        {
            txtDescription.text = expenseItemObj.Notes;
        }
        
        NSData *data = [[NSData alloc] initWithData:[NSData dataFromBase64String:expenseItemObj.byteFile]];
        UIImage *receiptImage = [UIImage imageWithData:data];
        imageView.image = receiptImage;
    }
    else
    {
        UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(uploadImage)];
        self.navigationItem.rightBarButtonItem = itemright;
        
        txtExpenseItemName.text = @"";
        txtExpenseItemName.placeholder = @"enter expense name";
        [btnExpenseSubmissionDate setTitle:@"     select date" forState:UIControlStateNormal];
        txtAmount.text = @"";
        txtAmount.placeholder = @"enter amount";
        txtDescription.text = @"";
        
        toolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithTitle:@"Choose Picture" style:UIBarButtonItemStyleDone target:self action:@selector(getPhotoFromAlbum)],
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Take Picture" style:UIBarButtonItemStyleDone target:self action:@selector(getPhotoFromCamera)],
                         nil];
    }
}

-(void)ShowExpenseSubmissionDatePicker
{
    [self.curTextField resignFirstResponder];
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"ExpenseSubmissionDate" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
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
    
    if(textField.tag == 2)
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


- (IBAction)textFieldDone:(id)sender
{
    [self.curTextField resignFirstResponder];
}

- (IBAction)uploadImage
{
    if(image == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please take photo of receipt." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //[APP_DELEGATE.arrayReceiptImages addObject:imageView.image];
    
    [self addExpenseItem];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RemoveImage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you really want to delete this record?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        alert.tag = 2;
        [alert show];
        return;
    
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

- (void) viewWillAppear:(BOOL)animated;
{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
	self.navigationItem.title = @"Scan Receipt";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
    imagePickerController.view.hidden = YES;
    
	imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self.view bringSubviewToFront:imageView];
    hasImage = TRUE;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    // Dismiss the image selection and close the program
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if(buttonIndex == 0)
        {
            [APP_DELEGATE.arrayExpenseItems removeObjectAtIndex:expenseItemIndex];
            [self.navigationController popViewControllerAnimated:TRUE];
        }
    }
}

-(void)addExpenseItem
{
    if([Util IsNullOrEmpty:txtExpenseItemName.text])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"please enter item name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([btnExpenseSubmissionDate.titleLabel.text isEqualToString:@"     select date"])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"please select submission date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([Util IsNullOrEmpty:txtAmount.text])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"please enter amount" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([Util IsNullOrEmpty:txtDescription.text])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"please enter description." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSDate *submissionDate = [Util convertStringToDate:btnExpenseSubmissionDate.titleLabel.text];
    
    if(expenseItemObj == nil || [expenseItemObj isEqual:[NSNull null]])
    {
        expenseItemObj =[[ExpenseItemObject alloc] initWithCode];
    }
    
    expenseItemObj.EmpID = [Util getUserId];
    expenseItemObj.ExpensemasterID = [NSNumber numberWithInt:-1];
    expenseItemObj.Expensename = txtExpenseItemName.text;
    expenseItemObj.ExpenseDate = [Util convertDateToJsonDate:submissionDate];
    expenseItemObj.Amount = [NSNumber numberWithFloat:[txtAmount.text floatValue]];
    expenseItemObj.Description = txtDescription.text;
    expenseItemObj.Notes = txtDescription.text;
    
    NSData *data = UIImagePNGRepresentation(image);
    NSString *byteArray  = [data base64Encoding];//[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    expenseItemObj.byteFile = byteArray;

    [APP_DELEGATE.arrayExpenseItems addObject:expenseItemObj];
}

@end
