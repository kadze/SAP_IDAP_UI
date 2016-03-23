//
//  SAPFriendDetailContext.m
//  IOSProject
//
//  Created by SAP on 3/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFriendDetailContext.h"

#import "SAPFacebookUser.h"

#import "SAPDispatch.h"

#import "SAPGraphStringConstants.h"

@implementation SAPFriendDetailContext

#pragma mark -
#pragma mark Accessors

- (FBSDKGraphRequest *)graphRequest {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@,%@{%@}",
                                 kSAPGengerKey,
                                 kSAPLagrePictureKey,
                                 kSAPUrlKey];
    
    NSDictionary *parameters = @{kSAPFieldsKey : fieldsParameter};
    
    SAPFacebookUser *user = self.model;
    
    return [[FBSDKGraphRequest alloc] initWithGraphPath:user.userId
                                             parameters:parameters];
}

- (id)completionHandler {
    SAPFacebookUser *user = self.model;
    
    return ^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error) {
            @synchronized (user) {
                user.state = kSAPModelStateDidFailLoading;
                
                return;
            }
        }
        
        user.gender = result[kSAPGengerKey];
        NSString *urlString = result[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
        user.imageURL = [NSURL URLWithString:urlString];
        
        @synchronized (user) {
            user.state = kSAPModelStateDidFinishLoading;
        };
    };
}

@end
