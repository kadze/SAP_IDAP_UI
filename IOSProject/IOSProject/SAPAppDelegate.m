//
//  AppDelegate.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPAppDelegate.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "SAPUsersViewController.h"
#import "SAPUsers.h"

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
        
    controller.users = users;
    self.users = users;
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
    
    //facebook
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (BOOL)        application:(UIApplication *)application
                    openURL:(NSURL *)url
          sourceApplication:(NSString *)sourceApplication
                 annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}
@end
