//
//  AppDelegate.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPAppDelegate.h"

#import "SAPUsersViewController.h"
#import "SAPUsers.h"
#import "SAPActivityIndicator.h"

#import "UIWindow+SAPExtensions.h"

@interface SAPAppDelegate ()
@property (nonatomic, retain) SAPUsers *users;

@end

@implementation SAPAppDelegate

- (BOOL)              application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    SAPUsersViewController *controller = [SAPUsersViewController new];
    
    SAPUsers *users = [SAPUsers new];
    
    controller.activityIndicator = [SAPActivityIndicator objectWithSuperView:controller.view];
    [users load];
    
    controller.users = users;
    self.users = users;
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.users save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
