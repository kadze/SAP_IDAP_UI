//
//  SAPFacebookFriendsContext.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookFriendsContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "SAPFacebookUser.h"
#import "SAPUsers.h"

#import "SAPGraphStringConstants.h"

@implementation SAPFacebookFriendsContext

@dynamic graphRequest;
@dynamic completionHandler;

#pragma mark -
#pragma mark Accessors

- (FBSDKGraphRequest *)graphRequest {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@{%@,%@,%@{%@}}",
                                 kSAPFriendsKey,
                                 kSAPFirstNameKey,
                                 kSAPLastNameKey,
                                 kSAPPictureKey,
                                 kSAPUrlKey];
    
    NSDictionary *parameters = @{kSAPFieldsKey : fieldsParameter};
    
    return [[FBSDKGraphRequest alloc] initWithGraphPath:kSAPUserGraphPath
                                             parameters:parameters];
}

- (id)completionHandler {
    SAPUsers *users = self.model;
    
    return ^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error) {
            @synchronized (users) {
                users.state = kSAPModelStateDidFailLoading;
                ///load from disk !!!!!!!
                return;
            }
        }
        
        NSArray *friends = result[kSAPFriendsKey][kSAPDataKey];
        for (id friend in friends) {
            SAPFacebookUser *user = [SAPFacebookUser new];
            user.userId = friend[kSAPIDKey];
            user.firstName = friend[kSAPFirstNameKey];
            user.lastName = friend[kSAPLastNameKey];
            NSString *urlString = friend[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
            user.imageURL = [NSURL URLWithString:urlString];
            
            [users addObject:user];
        }

        @synchronized (users) {
            users.state = kSAPModelStateDidFinishLoading;
        };
    };
}

//- (void)loadUserFromDisk {
//    [self.user.friends load];
//}


@end
