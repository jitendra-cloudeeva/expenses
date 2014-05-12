//
//  EmplyeeObject.h
//  expenses
//
//  Created by jrajoria on 5/12/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmployeeObject : NSObject

@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *password;

-(id)initWithCode;

- (NSMutableDictionary *)toNSDictionary;

@end
