//
//  ExpenceObject.m
//  Expenses
//
//  Created by nagaraja velicharla on 28/04/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "ExpenseObject.h"

@implementation ExpenseObject

@synthesize ExpenseID;
@synthesize EmpID;
@synthesize EmailID;
@synthesize ExpenseSubmissionDate;
@synthesize ClientName;
@synthesize Notes;
@synthesize Address;
@synthesize ExpensetypeID;
@synthesize ExpenseNumber;
@synthesize Amount;
@synthesize Name;
@synthesize CategoryName;
@synthesize EmpName;
@synthesize ID;


-(id)initWithCode:(NSNumber*)EmpID_
    ExpensetypeID:(NSNumber*)ExpensetypeID_
        ExpenseID:(NSNumber*)ExpenseID_
           Amount:(NSNumber*)Amount_
ExpenseSubmissionDate:(NSString*)ExpenseSubmissionDate_
          EmailID:(NSString*)EmailID_
       ClientName:(NSString*)ClientName_
            Notes:(NSString*)Notes_
          Address:(NSString*)Address_
    ExpenseNumber:(NSString*)ExpenseNumber_
             Name:(NSString*)Name_
     CategoryName:(NSString*)CategoryName_
          EmpName:(NSString*)EmpName_
               ID:(NSNumber*)ID_
{
    self = [super init];
    if (self) {
        self.EmpID = EmpID_;
        self.ExpensetypeID = ExpensetypeID_;
        self.ExpenseID = ExpenseID_;
        self.Amount = Amount_;
        self.ExpenseSubmissionDate = ExpenseSubmissionDate_;
        self.EmailID = EmailID_;
        self.ClientName = ClientName_;
        self.Notes = Notes_;
        self.Address = Address_;
        self.ExpenseNumber = ExpenseNumber_;
        self.Name = Name_;
        self.CategoryName = CategoryName_;
        self.EmpName = EmpName_;
        self.ID = ID_;
    }
    return self;
}


- (NSMutableDictionary *)toNSDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:self.EmpID forKey:@"EmpID"];
    [dictionary setValue:self.ExpensetypeID forKey:@"ExpensetypeID"];
    [dictionary setValue:self.ExpenseID forKey:@"ExpenseID"];
    [dictionary setValue:self.Amount forKey:@"Amount"];
    [dictionary setValue:self.ExpenseSubmissionDate forKey:@"ExpenseSubmissionDate"];
    [dictionary setValue:self.EmailID forKey:@"EmailID"];
    [dictionary setValue:self.ClientName forKey:@"ClientName"];
    [dictionary setValue:self.Notes forKey:@"Notes"];
    [dictionary setValue:self.Address forKey:@"Address"];
    [dictionary setValue:self.ExpenseNumber forKey:@"ExpenseNumber"];
    [dictionary setValue:self.Name forKey:@"Name"];
    [dictionary setValue:self.CategoryName forKey:@"CategoryName"];
    [dictionary setValue:self.EmpName forKey:@"EmpName"];
    [dictionary setValue:self.ID forKey:@"ID"];
    
    return dictionary;
}


@end
