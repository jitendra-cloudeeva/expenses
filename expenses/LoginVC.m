//
//  LoginVC.m
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "LoginVC.h"
#import "ExpensesListVC.h"

@interface LoginVC ()

@end

@implementation LoginVC


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:165/255.0f green:217/255.0f blue:235/255.0f alpha:1.0f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 100, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont systemFontOfSize:16];
	label.textColor = [UIColor blackColor];
	label.text = @"Username: " ;
	[self.view addSubview:label];
    
    txtUsername = [[UITextField alloc] initWithFrame:CGRectMake(110, 130, 190, 30)];
	txtUsername.font = [UIFont systemFontOfSize:16];
    txtUsername.tag = 1;
    txtUsername.textColor = [UIColor blackColor];
	txtUsername.placeholder = @"username";
    txtUsername.borderStyle = UITextBorderStyleLine;
    txtUsername.backgroundColor = [UIColor whiteColor];
    txtUsername.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtUsername.layer.borderWidth= 1.0f;
    [txtUsername addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    txtUsername.keyboardType = UIKeyboardTypeDefault;
    txtUsername.returnKeyType = UIReturnKeyDone;
    txtUsername.delegate = self;
	[self.view addSubview:txtUsername];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 100, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont systemFontOfSize:16];
	label.textColor = [UIColor blackColor];
	label.text = @"Password: " ;
	[self.view addSubview:label];
    
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(110, 180, 190, 30)];
	txtPassword.font = [UIFont systemFontOfSize:17];
    txtPassword.tag = 2;
    txtPassword.placeholder = @"password";
	txtPassword.textColor = [UIColor blackColor];
	txtPassword.borderStyle = UITextBorderStyleLine;
    txtPassword.backgroundColor = [UIColor whiteColor];
    txtPassword.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtPassword.layer.borderWidth= 1.0f;
    txtPassword.secureTextEntry = YES;
    [txtPassword addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    txtPassword.keyboardType = UIKeyboardTypeDefault;
    txtPassword.returnKeyType = UIReturnKeyDone;
    txtPassword.delegate = self;
    [self.view addSubview:txtPassword];
    
    btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    //[btnLogin setTitle:@"Login" forState:UIControlStateNormal];
    //[btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //btnLogin.titleLabel.font = [UIFont systemFontOfSize:15];
    btnLogin.frame = CGRectMake(145, 225, 120, 30);
    [btnLogin setImage:[UIImage imageNamed:@"signin.png"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    btnLogin.enabled = FALSE;
    [self.view addSubview:btnLogin];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:50/255.0f green:134/255.0f blue:221/255.0f alpha:1.0f];//[UIColor colorWithRed:47/255.0f green:177/255.0f blue:241/255.0f alpha:1.0f];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == txtPassword)
    {
        if ([[textField text] length] + [string length] - range.length > 3)
        {
            btnLogin.enabled = YES;
        }
        else
        {
            btnLogin.enabled = NO;
        }
    }
    
    if ([[textField text] length] + [string length] - range.length > 10)
    {
        return NO;
    }
    else
    {
        return YES;
    }
    
    return YES;
}

-(void)Login
{
    [txtPassword resignFirstResponder];
    if([txtUsername.text isEqualToString:txtPassword.text])
    {
        txtUsername.text = @"";
        txtPassword.text = @"";
        ExpensesListVC *evc = [[ExpensesListVC alloc] init];
        evc.title = @"Expenses";
        [self.navigationController pushViewController:evc animated:YES];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Invalid username or password, try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
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
