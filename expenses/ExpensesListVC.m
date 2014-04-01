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

@implementation ExpensesListVC

@synthesize arraySavedExpenses,arraySubmittedExpenses;

- (void)viewDidLoad
{
    [APP_DELEGATE.arrayReceiptImages removeAllObjects];
    
    arraySavedExpenses = [[NSMutableArray alloc] init];
    [arraySavedExpenses addObject:@"Trip to Gurgaon"];
    [arraySavedExpenses addObject:@"Hyderabad Visit"];
    [arraySavedExpenses addObject:@"USA Office Visit"];
    [arraySavedExpenses addObject:@"Delhi Office Expenses"];
    [arraySavedExpenses addObject:@"Bangalore Expenses"];
    
    arraySubmittedExpenses = [[NSMutableArray alloc] init];
    [arraySubmittedExpenses addObject:@"2013 Delhi Office Visit"];
    [arraySubmittedExpenses addObject:@"2014 USA Visit"];
    [arraySubmittedExpenses addObject:@"Canada Expenses"];
    [arraySubmittedExpenses addObject:@"Hyderabad Visit"];
    [arraySubmittedExpenses addObject:@"Pune Expenses"];
    
    tView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 460)];
	tView.delegate = self;
	tView.dataSource = self;
    tView.backgroundColor = [UIColor clearColor];
    //[tView setSeparatorColor:[UIColor whiteColor]];
    [self.view addSubview:tView];
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
        label.text = [NSString stringWithFormat:@"%@", [arraySavedExpenses objectAtIndex:indexPath.row]];
    }
    else
    {
        label.text = [NSString stringWithFormat:@"%@", [arraySubmittedExpenses objectAtIndex:indexPath.row]];
    }
    
    [[cell contentView] addSubview:label];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(5, 0, 320, 30);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    [view addSubview:label];
    
    if(section == 0)
    {
        label.text = @"Save Expenses";
    }
    if(section == 1)
    {
        label.text = @"Submitted Expenses";
    }
    return view;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpenseDetailsVC *edvc = [[ExpenseDetailsVC alloc] init];
    edvc.title = @"Expense Details";
    if (indexPath.section == 0)
    {
        [APP_DELEGATE.arrayReceiptImages removeAllObjects];
        edvc.isSubmitted = FALSE;
    }
    else
    {
        edvc.isSubmitted = TRUE;
    }
    [self.navigationController pushViewController:edvc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
