//
//  SAPUserDetailContext.m
//  IOSProject
//
//  Created by SAP on 3/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserDetailContext.h"

#import "SAPUser.h"

#import "SAPDispatch.h"

#import "SAPGraphStringConstants.h"

@implementation SAPUserDetailContext

@dynamic completionHandler;

#pragma mark -
#pragma mark Accessors

- (FBSDKGraphRequestHandler)completionHandler {
    SAPUser *user = self.model;
    
    return ^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error) {
            @synchronized (user) {
                user.state = kSAPModelStateDidFailLoading;
                
                return;
            }
        }
        
        user.gender = result[kSAPGengerKey];
        NSString *urlString = result[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
        user.largeImageURL = [NSURL URLWithString:urlString];
        
        @synchronized (user) {
            user.state = kSAPModelStateDidFinishLoading;
        };
    };
}

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    SAPUser *user = self.model;
    
    return user.userId;
}

- (NSDictionary *)graphRequestParameters {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@,%@{%@}",
                                 kSAPGengerKey,
                                 kSAPLargePictureKey,
                                 kSAPUrlKey];
    
    return @{kSAPFieldsKey : fieldsParameter};
}

@end
