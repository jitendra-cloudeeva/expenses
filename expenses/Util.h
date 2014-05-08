//
//  Util.h
//  expenses
//
//  Created by jrajoria on 5/4/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (void)setUserId:(NSString *)userId;
+ (NSNumber *)getUserId;

+ (void)setUserName:(NSString *)userName;
+ (NSString *)getUserName;

+ (void)setEmployeeName:(NSString *)employeeName;
+ (NSString *)getEmployeeName;

+ (void)setUserEmailID:(NSString *)email;
+ (NSString *)getUserEmailID;

+ (void)setUserStatus:(NSString *)userStatus;
+ (NSString *)getUserStatus;

+ (void)setUserActive:(NSString *)userActive;
+ (NSString *)getUserActive;

+ (NSDate *)deserializeJsonDateString: (NSString *)jsonDateString;

+ (NSString*)convert24HTimeTo12HTime:(NSString *)inputDate;
+ (BOOL)validateEmailWithString:(NSString*)email;
+ (BOOL)IsNullOrEmpty:(NSString*)strValue;
+ (BOOL)IsNumber:(NSString*)strValue;
+ (NSDate*)convertStringToDate:(NSString*)strDate;
+ (NSString*)convertDateToString:(NSDate*)date;
+ (NSString*)convertDateToJsonDate:(NSDate*)date;
+ (void)setUserPhone:(NSString *)userPhone;
+ (NSString *)getUserPhone;
+ (void)setUserPhotoId:(NSString *)userPhotoId;
+ (NSNumber *)getUserPhotoId;
+ (void)setExpenseId:(NSString *)expenseId;
+ (NSNumber *)getExpenseId;

@end
