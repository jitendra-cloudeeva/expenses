//
//  EmplyeeObject.m
//  expenses
//
//  Created by jrajoria on 5/12/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "EmployeeObject.h"

@implementation EmployeeObject

@synthesize username;
@synthesize password;

-(id)initWithCode
{
    self = [super init];
    if (self) {
        self.username = @"";
        self.password = @"";
    }
    return self;
}


- (NSMutableDictionary *)toNSDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:self.username forKey:@"username"];
    [dictionary setValue:self.password forKey:@"password"];
    
    return dictionary;
}

@end
