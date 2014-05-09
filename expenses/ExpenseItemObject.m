//
//  ExpenseItemObject.m
//  expenses
//
//  Created by jrajoria on 5/9/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "ExpenseItemObject.h"

@implementation ExpenseItemObject

@synthesize EmpID;
@synthesize ExpenseID;
@synthesize ExpensemasterID;
@synthesize Expensename;
@synthesize ExpenseDate;
@synthesize Amount;
@synthesize Description;

@synthesize AttachmentID;
@synthesize Filename;
@synthesize byteFile;
@synthesize FileContentType;
@synthesize FileExtension;
@synthesize Notes;


-(id)initWithCode
{
//    self = [super init];
//    if (self) {
//        self.EmpID = EmpID_;
//        self.ExpenseID = ExpenseID_;
//        self.ExpensemasterID = ExpensemasterID_;
//        self.ExpenseName = ExpenseName_;
//        self.ExpenseDate = ExpenseDate_;
//        self.Amount = Amount_;
//        self.Description = Description_;
//        
//        self.AttachmentID = AttachmentID_;
//        self.Filename = Filename_;
//        self.AttachmentFile = AttachmentFile_;
//        self.FileContentType = FileContentType_;
//        self.FileExtension = FileExtension_;
//        self.Notes = Notes_;
//    }
//    return self;
    
    self = [super init];
    if (self) {
        self.EmpID = [NSNumber numberWithInt:0];
        self.ExpenseID = [NSNumber numberWithInt:-1];
        self.ExpensemasterID = [NSNumber numberWithInt:0];
        self.Expensename = @"ww";
        self.ExpenseDate = @"ww";
        self.Amount = [NSNumber numberWithFloat:0.0];
        self.Description = @"ww";
        
        self.AttachmentID = [NSNumber numberWithInt:0];
        self.Filename = @"image.jpg";
        self.byteFile = @"ww";
        self.FileContentType = @"image/jpeg";
        self.FileExtension = @".jpg";
        
        self.Notes = @"ww";
    }
    return self;
}


- (NSMutableDictionary *)toNSDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:self.EmpID forKey:@"EmpID"];
    [dictionary setValue:self.ExpenseID forKey:@"ExpenseID"];
    [dictionary setValue:self.ExpensemasterID forKey:@"ExpensemasterID"];
    [dictionary setValue:self.Expensename forKey:@"Expensename"];
    [dictionary setValue:self.ExpenseDate forKey:@"ExpenseDate"];
    [dictionary setValue:self.Amount forKey:@"Amount"];
    [dictionary setValue:self.Description forKey:@"Description"];
    
    [dictionary setValue:self.AttachmentID forKey:@"AttachmentID"];
    [dictionary setValue:self.Filename forKey:@"Filename"];
    [dictionary setValue:self.byteFile forKey:@"byteFile"];
    [dictionary setValue:self.FileContentType forKey:@"FileContentType"];
    [dictionary setValue:self.FileExtension forKey:@"FileExtension"];
    
    [dictionary setValue:self.Notes forKey:@"Notes"];
    
    return dictionary;
}


@end
