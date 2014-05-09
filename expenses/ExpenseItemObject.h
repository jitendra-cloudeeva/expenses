//
//  ExpenseItemObject.h
//  expenses
//
//  Created by jrajoria on 5/9/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpenseItemObject : NSObject

@property(nonatomic,strong) NSNumber *EmpID;
@property(nonatomic,strong) NSNumber *ExpenseID;
@property(nonatomic,strong) NSNumber *ExpensemasterID;
@property(nonatomic,strong) NSString *Expensename;
@property(nonatomic,strong) NSString *ExpenseDate;
@property(nonatomic,strong) NSNumber *Amount;
@property(nonatomic,strong) NSString *Description;

@property(nonatomic,strong) NSNumber *AttachmentID;
@property(nonatomic,strong) NSString *Filename;
@property(nonatomic,strong) NSString *byteFile;
@property(nonatomic,strong) NSString *FileContentType;
@property(nonatomic,strong) NSString *FileExtension;

@property(nonatomic,strong) NSString *Notes;


-(id)initWithCode;


- (NSMutableDictionary *)toNSDictionary;

@end

