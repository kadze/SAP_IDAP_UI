//
//  AppDelegate.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPAppDelegate.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "SAPLoginViewController.h"
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
    
    SAPLoginViewController *controller = [SAPLoginViewController new];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
//    SAPUsers *users = [SAPUsers new];
//        
//    controller.users = users;
//    self.users = users;
    
    window.rootViewController = navigationController;
    
    [window makeKeyAndVisible];
    
    //facebook
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
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
