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
    
    self.view.backgroundColor = [UIColor clearColor];
    
    txtUsername = [[UITextField alloc] initWithFrame:CGRectMake(30, 130, 260, 30)];
	txtUsername.font = [UIFont systemFontOfSize:17];
    txtUsername.tag = 1;
    txtUsername.textColor = [UIColor blackColor];
	txtUsername.placeholder = @"username*";
    txtUsername.borderStyle = UITextBorderStyleLine;
    txtUsername.backgroundColor = [UIColor whiteColor];
    txtUsername.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtUsername.layer.borderWidth= 1.0f;
    [txtUsername addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    txtUsername.keyboardType = UIKeyboardTypeDefault;
    txtUsername.returnKeyType = UIReturnKeyDone;
    txtUsername.delegate = self;
	[self.view addSubview:txtUsername];
    
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(30, 190, 260, 30)];
	txtPassword.font = [UIFont systemFontOfSize:17];
    txtPassword.tag = 2;
    txtPassword.placeholder = @"password*";
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
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    //[btnLogin setTitle:@"Login" forState:UIControlStateNormal];
    //[btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //btnLogin.titleLabel.font = [UIFont systemFontOfSize:15];
    btnLogin.frame = CGRectMake(90, 235, 120, 30);
    [btnLogin setImage:[UIImage imageNamed:@"signin.png"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:47/255.0f green:177/255.0f blue:241/255.0f alpha:1.0f];
}

-(void)Login
{
    ExpensesListVC *evc = [[ExpensesListVC alloc] init];
    evc.title = @"Expenses";
    [self.navigationController pushViewController:evc animated:YES];
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
