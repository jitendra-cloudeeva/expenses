//
//  ExpensesListVC.m
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "ExpensesListVC.h"
#import "ExpenseDetailsVC.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Util.h"
#import "ExpenseObject.h"
#import "MBProgressHUD.h"

@implementation ExpensesListVC

@synthesize arraySavedExpenses,arraySubmittedExpenses;

- (void)viewDidLoad
{
    [APP_DELEGATE.arrayExpenseItems removeAllObjects];
    
    self.view.backgroundColor = [UIColor colorWithRed:165/255.0f green:217/255.0f blue:235/255.0f alpha:1.0f];
    
    arraySavedExpenses = [[NSMutableArray alloc] init];
    arraySubmittedExpenses = [[NSMutableArray alloc] init];
    
    tView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	tView.delegate = self;
	tView.dataSource = self;
    tView.separatorInset = UIEdgeInsetsZero;
    tView.backgroundColor = [UIColor colorWithRed:165/255.0f green:217/255.0f blue:235/255.0f alpha:1.0f];
    //[tView setSeparatorColor:[UIColor whiteColor]];
    [self.view addSubview:tView];
    
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(Logout)];
    self.navigationItem.leftBarButtonItem = itemleft;
    
    UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStylePlain target:self action:@selector(createNewExpense)];
    self.navigationItem.rightBarButtonItem = itemright;
}


- (void) viewWillAppear:(BOOL)animated;
{
    [arraySubmittedExpenses removeAllObjects];
    [self getExpenseList];
}

-(void)getExpenseList
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[Util getUserId], @"EmpID",[Util getUserStatus], @"Ustatus", nil];
    
    NSString *URL = [BASE_URL stringByAppendingString:[NSString stringWithFormat:@"GetExpenses"]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager GET:URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSLog(@"responseObject = %@", responseObject);
         NSArray *arrayJSON = (NSArray*)[responseObject valueForKeyPath:@"JGetExpensesResult"];
         
         if (arrayJSON != nil && ![arrayJSON isEqual:[NSNull null]])
         {
             for(NSDictionary *obj in arrayJSON)
             {
                 ExpenseObject *expense =[[ExpenseObject alloc] init];
                 
                 expense.ClientAddress = [obj objectForKey:@"ClientAddress"];
                 expense.Amount= [obj objectForKey:@"Amount"];
                 expense.ClientName = [obj objectForKey:@"ClientName"];
                 expense.EmailID = [obj objectForKey:@"EmailID"];
                 expense.EmpID = [obj objectForKey:@"EmpID"];
                 expense.ExpenseID = [obj objectForKey:@"ExpenseID"];
                 expense.ExpenseNumber = [obj objectForKey:@"ExpenseNumber"];
                 expense.ExpenseSubmissionDate = [Util  deserializeJsonDateString:[obj objectForKey:@"ExpenseSubmissionDate"]];
                 expense.ExpensetypeID = [obj objectForKey:@"ExpensetypeID"];
                 expense.Name = [obj objectForKey:@"Name"];
                 expense.Notes = [obj objectForKey:@"Notes"];
                 expense.Status = [obj objectForKey:@"Status"];
                 
                 if([expense.Status integerValue] > -1)
                 {
                     [arraySubmittedExpenses addObject:expense];
                 }
                 else
                 {
                     [arraySavedExpenses addObject:expense];
                 }
                 
                 [tView reloadData];
             }
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSLog(@"error %@",error);
         UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Invalid username or password, try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }];
}


-(void)Logout
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)createNewExpense
{
    ExpenseDetailsVC *edvc = [[ExpenseDetailsVC alloc] init];
    edvc.title = @"New Expense";
    edvc.isNew = TRUE;
    [APP_DELEGATE.arrayExpenseItems removeAllObjects];
    edvc.isSubmitted = FALSE;
    edvc.expenseObj = nil;
    [self.navigationController pushViewController:edvc animated:YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return [arraySavedExpenses count];
    }
    else
    {
        return [arraySubmittedExpenses count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 40.0f;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =nil;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mycell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 8, 230, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont systemFontOfSize:16];
	label.textColor = [UIColor blackColor];
    
    if(indexPath.section == 0)
    {
        ExpenseObject *ee = [arraySavedExpenses objectAtIndex:indexPath.row];
        label.text = ee.ExpenseNumber;
    }
    else
    {
        ExpenseObject *ee = [arraySubmittedExpenses objectAtIndex:indexPath.row];
        label.text = ee.ExpenseNumber;
    }
    
    [[cell contentView] addSubview:label];
    
    //cell.backgroundColor = [UIColor colorWithRed:165/255.0f green:217/255.0f blue:235/255.0f alpha:1.0f];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"   Saved Expenses";
    else
        return @"   Submitted Expenses";
}

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(5, 0, 320, 30);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    [view addSubview:label];
    
    if(section == 0)
    {
        label.text = @"Saved Expenses";
    }
    if(section == 1)
    {
        label.text = @"Submitted Expenses";
    }
    return view;
}*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [APP_DELEGATE.arrayExpenseItems removeAllObjects];
    ExpenseDetailsVC *edvc = [[ExpenseDetailsVC alloc] init];
    
    if (indexPath.section == 0)
    {
        edvc.isSubmitted = FALSE;
        ExpenseObject *expense = [arraySavedExpenses objectAtIndex:indexPath.row];
        edvc.title = expense.ExpenseNumber;
        edvc.expenseObj = expense;
    }
    else
    {
        edvc.isSubmitted = TRUE;
        ExpenseObject *expense = [arraySubmittedExpenses objectAtIndex:indexPath.row];
        edvc.title = expense.ExpenseNumber;
        edvc.expenseObj = expense;
    }
    [self.navigationController pushViewController:edvc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
