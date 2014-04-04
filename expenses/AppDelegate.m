//
//  AppDelegate.m
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize navController,arrayReceiptImages;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.arrayReceiptImages = [[NSMutableArray alloc] init];
    
    lvc = [[LoginVC alloc] init];
    lvc.title = @"Cloudeeva - Login";
    navController = [[UINavigationController alloc] initWithRootViewController:lvc];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:navController.view];
    [self.window makeKeyAndVisible];
    NSLog(@"Rahul");
    // Override point for customization after application launch.
    return YES;
}

-(NSString*)convert24HTimeTo12HTime:(NSString *)inputDate
{
    NSDateFormatter *inTimeFormatter = [[NSDateFormatter alloc] init];
    [inTimeFormatter setDateFormat:@"HH:mm:ss"];
    NSDate *date = [inTimeFormatter dateFromString:inputDate];
    
    NSDateFormatter *outTimeFormatter = [[NSDateFormatter alloc] init];
    [outTimeFormatter setDateFormat:@"hh:mm a"];
    return [outTimeFormatter stringFromDate:date];
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(BOOL)IsNullOrEmpty:(NSString*)strValue
{
    NSString *value = [strValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (value == nil || [value isEqualToString:@""])
    {
        return TRUE;
    }
    return FALSE;
}

-(BOOL)IsNumber:(NSString*)strValue
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
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
