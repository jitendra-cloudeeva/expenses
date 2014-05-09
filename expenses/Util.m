//
//  Util.m
//  expenses
//
//  Created by jrajoria on 5/4/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "Util.h"

@implementation Util


+ (void)setUserId:(NSString *)userId
{
    if (userId == nil || [userId isEqual:[NSNull null]]) {
        userId = @"0";
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:userId forKey:@"userId"];
}

+ (NSNumber *)getUserId
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *userId = [prefs objectForKey:@"userId"];
    
    return userId;
}

+ (void)setUserPhotoId:(NSString *)userPhotoId
{
    if (userPhotoId == nil || [userPhotoId isEqual:[NSNull null]]) {
        userPhotoId = @"0";
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:userPhotoId forKey:@"userPhotoId"];
}

+ (NSNumber *)getUserPhotoId
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *userPhotoId = [prefs objectForKey:@"userPhotoId"];
    
    return userPhotoId;
}

+ (void)setExpenseId:(NSString *)expenseId
{
    if (expenseId == nil || [expenseId isEqual:[NSNull null]]) {
        expenseId = @"0";
    }
    NSNumber *expID = [NSNumber numberWithInt:[expenseId integerValue]];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:expID forKey:@"expenseId"];
}

+ (NSNumber *)getExpenseId
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *expenseId = [prefs objectForKey:@"expenseId"];
    
    return expenseId;
}

+ (void)setUserName:(NSString *)userName
{
    if (userName == nil || [userName isEqual:[NSNull null]]) {
        userName = @"";
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:userName forKey:@"userName"];
}

+ (NSString *)getUserName
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *userName = [prefs objectForKey:@"userName"];
    
    if (userName != nil && ![userName isEqualToString:@""]) {
        return userName;
    }
    return @"";
}

+ (void)setUserPhone:(NSString *)userPhone
{
    if (userPhone == nil || [userPhone isEqual:[NSNull null]]) {
        userPhone = @"";
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:userPhone forKey:@"userPhone"];
}

+ (NSString *)getUserPhone
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *userPhone = [prefs objectForKey:@"userPhone"];
    
    if (userPhone != nil && ![userPhone isEqualToString:@""]) {
        return userPhone;
    }
    return @"";
}

+ (void)setEmployeeName:(NSString *)employeeName
{
    if (employeeName == nil || [employeeName isEqual:[NSNull null]]) {
        employeeName = @"";
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:employeeName forKey:@"employeeName"];
}

+ (NSString *)getEmployeeName
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *employeeName = [prefs objectForKey:@"employeeName"];
    
    if (employeeName != nil && ![employeeName isEqualToString:@""]) {
        return employeeName;
    }
    return @"";
}

+ (void)setUserEmailID:(NSString *)email
{
    if (email == nil || [email isEqual:[NSNull null]]) {
        email = @"";
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:email forKey:@"userEmail"];
}

+ (NSString *)getUserEmailID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *userEmailID = [prefs objectForKey:@"userEmail"];
    
    if (userEmailID != nil && ![userEmailID isEqualToString:@""]) {
        return userEmailID;
    }
    return @"";
}

+ (void)setUserStatus:(NSString *)userStatus
{
    if (userStatus == nil || [userStatus isEqual:[NSNull null]]) {
        userStatus = @"";
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:userStatus forKey:@"userStatus"];
}

+ (NSString *)getUserStatus
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *userStatus = [prefs objectForKey:@"userStatus"];
    
    if (userStatus != nil && ![userStatus isEqualToString:@""]) {
        return userStatus;
    }
    return @"";
}

+ (void)setUserActive:(NSString *)userActive
{
    if (userActive == nil || [userActive isEqual:[NSNull null]]) {
        userActive = @"";
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:userActive forKey:@"userActive"];
}

+ (NSString *)getUserActive
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *userActive = [prefs objectForKey:@"userActive"];
    
    if (userActive != nil && ![userActive isEqualToString:@""]) {
        return userActive;
    }
    return @"";
}

+ (NSDate *)deserializeJsonDateString: (NSString *)jsonDateString
{
    NSInteger offset = [[NSTimeZone defaultTimeZone] secondsFromGMT]; //get number of seconds to add or subtract according to the client default time zone
    
    NSInteger startPosition = [jsonDateString rangeOfString:@"("].location + 1; //start of the date value
    
    NSTimeInterval unixTime = [[jsonDateString substringWithRange:NSMakeRange(startPosition, 13)] doubleValue] / 1000; //WCF will send 13 digit-long value for the time interval since 1970 (millisecond precision) whereas iOS works with 10 digit-long values (second precision), hence the divide by 1000
    
    NSDate *date = [[NSDate dateWithTimeIntervalSince1970:unixTime] dateByAddingTimeInterval:offset];
    
    return date;
}

+ (NSString*)convert24HTimeTo12HTime:(NSString *)inputDate
{
    NSDateFormatter *inTimeFormatter = [[NSDateFormatter alloc] init];
    [inTimeFormatter setDateFormat:@"HH:mm:ss"];
    NSDate *date = [inTimeFormatter dateFromString:inputDate];
    
    NSDateFormatter *outTimeFormatter = [[NSDateFormatter alloc] init];
    [outTimeFormatter setDateFormat:@"hh:mm a"];
    return [outTimeFormatter stringFromDate:date];
}

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)IsNullOrEmpty:(NSString*)strValue
{
    NSString *value = [strValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (value == nil || [value isEqualToString:@""])
    {
        return TRUE;
    }
    return FALSE;
}

+ (BOOL)IsNumber:(NSString*)strValue
{
    NSString *value = [strValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSError *error1 = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^([0-9]+)?(\\.([0-9]{1,2})?)?$" options:NSRegularExpressionCaseInsensitive error:&error1];
    NSUInteger matches = [regex numberOfMatchesInString:value options:0 range:NSMakeRange(0, [value length])];
    
    if (matches == 0)
    {
        return FALSE;
    }
    return TRUE;
}

+ (NSDate*)convertStringToDate:(NSString*)strDate
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.dateStyle = NSDateFormatterShortStyle;
    [inputFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [inputFormatter dateFromString:strDate];
    
    return date;
}

+ (NSString*)convertDateToString:(NSDate*)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [outputFormatter stringFromDate:date];
    return strDate;
}

+ (NSString*)convertDateToJsonDate:(NSDate*)date
{
    CFTimeInterval startDate = [date timeIntervalSince1970] * 1000;
    NSString *dateJson = [NSString stringWithFormat:@"/Date(%.0f+0800)/", startDate];
    return dateJson;
}

+(NSDate*) dateFromDotNet:(NSString*)stringDate{
    
    NSDate *returnValue;
    
    if ([stringDate isMemberOfClass:[NSNull class]]) {
        returnValue=nil;
    }
    else  {
        NSInteger offset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
        
        returnValue= [[NSDate dateWithTimeIntervalSince1970:
                       [[stringDate substringWithRange:NSMakeRange(6, 10)] intValue]]
                      dateByAddingTimeInterval:offset];
    }
    
    return returnValue;
    
}


@end
