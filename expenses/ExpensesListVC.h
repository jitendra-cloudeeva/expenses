//
//  ExpensesListVC.h
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpensesListVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tView;
    NSMutableArray *arraySavedExpenses;
    NSMutableArray *arraySubmittedExpenses;
}

@property(nonatomic,strong) NSMutableArray *arraySavedExpenses;
@property(nonatomic,strong) NSMutableArray *arraySubmittedExpenses;

@end
