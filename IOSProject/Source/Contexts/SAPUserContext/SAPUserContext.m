//
//  SAPUserContext.m
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserContext.h"

#import "SAPUser.h"

#import "SAPJSONRepresentationImports.h"

#import "SAPNilToNSNullMacro.h"

#import "SAPGraphStringConstants.h"

@implementation SAPUserContext

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    SAPUser *user = self.model;
    
    return user.userId;
}

- (NSDictionary *)graphRequestParameters {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@,%@,%@{%@}",
                                 kSAPFirstNameKey,
                                 kSAPLastNameKey,
                                 kSAPSquarePictureWithAliasKey,
                                 kSAPUrlKey];
    
    return @{kSAPFieldsKey : fieldsParameter};
}

- (NSDictionary *)cachedResult {
    NSDictionary *result = nil;
    SAPUser *cachedModel = self.model;
        result = @{kSAPIDKey : SAPNSNullIfNil(cachedModel.userId),
                   kSAPFirstNameKey : SAPNSNullIfNil(cachedModel.firstName),
                   kSAPLastNameKey : SAPNSNullIfNil(cachedModel.lastName)
                   //,
//                   kSAPSquarePictureAliasKey : @{
//                           kSAPDataKey : @{
//                                   kSAPUrlKey : SAPNSNullIfNil(cachedModel.smallImageURL)}
//                           }
                   };
//    }

    return [result JSONRepresentation];
}

- (void)fillModelWithResult:(NSDictionary *)result {
    SAPUser *user = self.model;
    
    user.userId = result[kSAPIDKey];
    user.firstName = result[kSAPFirstNameKey];
    user.lastName = result[kSAPLastNameKey];
    
//    NSString *urlString = result[kSAPSquarePictureAliasKey][kSAPDataKey][kSAPUrlKey];
//    user.smallImageURL = [NSURL URLWithString:urlString];
}

@end
