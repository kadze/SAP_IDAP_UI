//
//  SAPUserContext.m
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserContext.h"

#import "SAPUser.h"

#import "SAPDispatch.h"

#import "SAPGraphStringConstants.h"

@implementation SAPUserContext

#pragma mark -
#pragma mark Accessors

- (FBSDKGraphRequest *)graphRequest {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@,%@,%@{%@}",
                                 kSAPFirstNameKey,
                                 kSAPLastNameKey,
                                 kSAPPictureKey,
                                 kSAPUrlKey];
    
    NSDictionary *parameters = @{kSAPFieldsKey : fieldsParameter};
    
    return [[FBSDKGraphRequest alloc] initWithGraphPath:kSAPUserGraphPath
                                             parameters:parameters];
}

- (FBSDKGraphRequestHandler)completionHandler {
    SAPUser *user = self.model;
    
    return ^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error) {
            @synchronized (user) {
                user.state = kSAPModelStateDidFailLoading;
                
                return;
            }
        }
        
        user.userId = result[kSAPIDKey];
        user.firstName = result[kSAPFirstNameKey];
        user.lastName = result[kSAPLastNameKey];
        NSString *urlString = result[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
        user.imageURL = [NSURL URLWithString:urlString];
        
        @synchronized (user) {
            user.state = kSAPModelStateDidFinishLoading;
        };
    };
}

@end
