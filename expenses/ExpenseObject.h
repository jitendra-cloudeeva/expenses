//
//  ExpenceObject.h
//  Expenses
//
//  Created by nagaraja velicharla on 28/04/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpenseObject : NSObject

@property(nonatomic,strong) NSNumber *EmpID;
@property(nonatomic,strong) NSNumber *ExpensetypeID;
@property(nonatomic,strong) NSNumber *ExpenseID;
@property(nonatomic,strong) NSNumber *Amount;
@property(nonatomic,strong) NSString *ExpenseSubmissionDate;
@property(nonatomic,strong) NSString *EmailID;
@property(nonatomic,strong) NSString *ClientName;
@property(nonatomic,strong) NSString *Notes;
@property(nonatomic,strong) NSString *ClientAddress;
@property(nonatomic,strong) NSString *ExpenseNumber;
@property(nonatomic,strong) NSString *Name;
@property(nonatomic,strong) NSString *CategoryName;
@property(nonatomic,strong) NSString *EmpName;
@property(nonatomic,strong) NSNumber *ID;
@property(nonatomic,strong) NSNumber *Status;
@property(nonatomic,strong) NSString *Phone;

-(id)initWithCode:(NSNumber*)EmpID_
            ExpensetypeID:(NSNumber*)ExpensetypeID_
                ExpenseID:(NSNumber*)ExpenseID_
                   Amount:(NSNumber*)Amount_
    ExpenseSubmissionDate:(NSString*)ExpenseSubmissionDate_
                  EmailID:(NSString*)EmailID_
               ClientName:(NSString*)ClientName_
                    Notes:(NSString*)Notes_
                  ClientAddress:(NSString*)ClientAddress_
            ExpenseNumber:(NSString*)ExpenseNumber_
                     Name:(NSString*)Name_
     CategoryName:(NSString*)CategoryName_
EmpName:(NSString*)EmpName_
    ID:(NSNumber*)ID_
Status:(NSNumber*)Status_
            Phone:(NSString*)Phone_;


- (NSMutableDictionary *)toNSDictionary;

@end
