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

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    SAPUser *user = self.model;
    
    return user.userId;
}

- (NSDictionary *)graphRequestParameters {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@,%@{%@}",
                                 kSAPGenderKey,
                                 kSAPLargePictureKey,
                                 kSAPUrlKey];
    
    return @{kSAPFieldsKey : fieldsParameter};
}

- (void)fillModelWithResult:(NSDictionary *)result {
    SAPUser *user = self.model;
    user.gender = result[kSAPGenderKey];
    NSString *urlString = result[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
    user.largeImageURL = [NSURL URLWithString:urlString];
}

@end
