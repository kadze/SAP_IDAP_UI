//
//  SAPFacebookLoginViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPLoginViewController.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKAccessToken.h>

#import <CoreData/CoreData.h>

#import "SAPLoginView.h"
#import "SAPUserFriendsViewController.h"
#import "SAPUser.h"
#import "SAPFacebookLoginContext.h"
#import "SAPModel.h"

#import "SAPCoreDataController.h"

#import "UIAlertView+SAPExtensions.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPLoginViewController, SAPLoginView, mainView);

@interface SAPLoginViewController ()

- (void)finishLogin;
- (SAPUser *)currentTokenIDUser;

@end

@implementation SAPLoginViewController

@dynamic modelContext;

#pragma mark -
#pragma mark Accessors

- (SAPContext *)modelContext {
    SAPFacebookLoginContext *context = [SAPFacebookLoginContext contextWithModel:self.model];
    context.controller = self;
    
    return context;
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self finishLogin];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    self.model = [SAPModel new];
    self.context = self.modelContext;
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    [self finishLogin];
}

#pragma mark -
#pragma mark Private

- (SAPUser *)currentTokenIDUser {
    SAPUser *user = nil;
    FBSDKAccessToken *accessToken = [FBSDKAccessToken currentAccessToken];
    if (accessToken) {
        NSString *tokenUserID = accessToken.userID;
        NSString *entityName = NSStringFromClass([SAPUser class]);
        NSError *error = nil;
        
        SAPCoreDataController *controller = [[SAPCoreDataController alloc] init];
        NSManagedObjectContext *managedObjectContext = controller.managedObjectContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@", tokenUserID];
        request.predicate = predicate;
        NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
        if (!results) {
            [UIAlertView showWithError:error];
        }
        
        if (results.count == 0) {
            user = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:managedObjectContext];
            user.userId = tokenUserID;
            
            if (![managedObjectContext save:&error]) {
                [UIAlertView showWithError:error];
            }
            
        } else {
            user = results.firstObject;
        }
    }
    
    return user;
}

- (void)finishLogin {
    SAPUser *user = [self currentTokenIDUser];
    if (user) {
        SAPUserFriendsViewController *controller = [SAPUserFriendsViewController new];
        controller.model = user;
        
        [self.navigationController pushViewController:controller animated:NO];
    }
}

@end
