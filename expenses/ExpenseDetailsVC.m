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

@synthesize isSubmitted;

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
    UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(15, 80, 90, 90)];
    picture.image = [UIImage imageNamed:@"jitu.png"];
    [self.view addSubview:picture];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, 80, 70, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"Name: ";
    [self.view addSubview:label];
    
    lblName = [[UILabel alloc] initWithFrame:CGRectMake(170, 80, 200, 30)];
    lblName.backgroundColor = [UIColor clearColor];
	lblName.font = [UIFont systemFontOfSize:14];
	lblName.textColor = [UIColor blackColor];
	lblName.text = @"Jitendra Rajoria";
    [self.view addSubview:lblName];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(120, 110, 70, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"Email: ";
    [self.view addSubview:label];
    
    lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(170, 110, 200, 30)];
    lblEmail.backgroundColor = [UIColor clearColor];
	lblEmail.font = [UIFont systemFontOfSize:14];
	lblEmail.textColor = [UIColor blackColor];
	lblEmail.text = @"jrajoria@cloudeeva.com";
    [self.view addSubview:lblEmail];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(120, 140, 70, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"Phone: ";
    [self.view addSubview:label];
    
    lblPhone = [[UILabel alloc] initWithFrame:CGRectMake(170, 140, 200, 30)];
    lblPhone.backgroundColor = [UIColor clearColor];
	lblPhone.font = [UIFont systemFontOfSize:14];
	lblPhone.textColor = [UIColor blackColor];
	lblPhone.text = @"+91-9560888706";
    [self.view addSubview:lblPhone];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 180, 180, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"Expense Submission Date: ";
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(195, 180, 180, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont systemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"1st April 2014";
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 210, 180, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"Expense Type: ";
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(115, 210, 180, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont systemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"Travel";
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 240, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"Client Name: ";
    [self.view addSubview:label];
    
    txtClientName = [[UITextField alloc] initWithFrame:CGRectMake(110, 240, 160, 30)];
	txtClientName.font = [UIFont systemFontOfSize:15];
    txtClientName.tag = 1;
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
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"Details: ";
    [self.view addSubview:label];
    
    UITextView *description = [[UITextView alloc] initWithFrame:CGRectMake(110, 275, 160, 50)];
    description.backgroundColor = [UIColor whiteColor];
    description.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    description.layer.borderWidth= 1.0f;
    description.text = @"Cloudeeva Inc.";
    description.scrollEnabled = YES;
    description.pagingEnabled = YES;
    description.editable = YES;
    description.font = [UIFont systemFontOfSize:14];
    description.textColor = [UIColor blackColor];
    description.keyboardType = UIKeyboardTypeDefault;
    description.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:description];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 330, 140, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textColor = [UIColor blackColor];
	label.text = @"Amount: ";
    [self.view addSubview:label];
    
    txtAmount = [[UITextField alloc] initWithFrame:CGRectMake(110, 330, 160, 30)];
	txtAmount.font = [UIFont systemFontOfSize:15];
    txtAmount.tag = 2;
    txtAmount.text = @"10,000";
    txtAmount.textColor = [UIColor blackColor];
	txtAmount.borderStyle = UITextBorderStyleLine;
    txtAmount.backgroundColor = [UIColor whiteColor];
    txtAmount.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtAmount.layer.borderWidth= 1.0f;
    [txtAmount addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    txtAmount.keyboardType = UIKeyboardTypeDefault;
    txtAmount.returnKeyType = UIReturnKeyDone;
    txtAmount.delegate = self;
    [self.view addSubview:txtAmount];
    
    UIButton *btnUploadInvoice = [UIButton buttonWithType:UIButtonTypeCustom];
    btnUploadInvoice.frame = CGRectMake(10, 360, 120, 40);
    [btnUploadInvoice setTitle:@"Upload Invoice" forState:UIControlStateNormal];
    [btnUploadInvoice setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnUploadInvoice.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    //[btnUploadInvoice setImage:[UIImage imageNamed:@"invoice.png"] forState:UIControlStateNormal];
    [btnUploadInvoice addTarget:self action:@selector(uploadInvoice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnUploadInvoice];
    
    if([APP_DELEGATE.arrayReceiptImages count] > 0)
    {
        for (int i = 0; i < [APP_DELEGATE.arrayReceiptImages count]; i++)
        {
            /*UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake((i * 40)+5, btnUploadInvoice.frame.origin.y + 30, 40, 40)];
            picture.image = [APP_DELEGATE.arrayReceiptImages objectAtIndex:i];
            [self.view addSubview:picture];*/
            
            UIButton *btnPicture = [UIButton buttonWithType:UIButtonTypeCustom];
            btnPicture.tag = i;
            [btnPicture setFrame:CGRectMake((i * 40)+5, btnUploadInvoice.frame.origin.y + 30, 40, 40)];
            [btnPicture setImage:[APP_DELEGATE.arrayReceiptImages objectAtIndex:i] forState:UIControlStateNormal];
            [btnPicture addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btnPicture];
        }
    }
    
    if(!isSubmitted)
    {
        UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSave.tag = 1;
        [btnSave setFrame:CGRectMake(115, 443, 240, 30)];
        [btnSave setImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
        [btnSave addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSave];
        
        UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSubmit setFrame:CGRectMake(10, 443, 135, 30)];
        btnSubmit.tag = 2;
        [btnSubmit setImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
        [btnSubmit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSubmit];
    }
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
    scan.image = [APP_DELEGATE.arrayReceiptImages objectAtIndex:btn.tag];
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
	[sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
