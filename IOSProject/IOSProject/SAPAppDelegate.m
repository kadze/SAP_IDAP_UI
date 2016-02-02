//
//  AppDelegate.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPAppDelegate.h"

#import "SAPSquareViewController.h"
#import "UIWindow+SAPExtentions.h"

@interface SAPAppDelegate ()

@end

@implementation SAPAppDelegate

- (BOOL)              application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    SAPSquareViewController *controller = [SAPSquareViewController new];
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
