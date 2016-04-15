//
//  SAPUserDetailContext.m
//  IOSProject
//
//  Created by SAP on 3/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserDetailContext.h"

#import "SAPUser.h"

#import "SAPJSONRepresentation.h"

#import "SAPGraphStringConstants.h"

#import "SAPNilToNSNullMacro.h"

@implementation SAPUserDetailContext

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    SAPUser *user = self.model;
    
    return user.userId;
}

- (NSDictionary *)graphRequestParameters {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@,%@,%@,%@{%@},%@{%@}",
                                 kSAPFirstNameKey,
                                 kSAPLastNameKey,
                                 kSAPGenderKey,
                                 kSAPSquarePictureWithAliasKey,
                                 kSAPUrlKey,
                                 kSAPLargeSquarePictureWithAliasKey,
                                 kSAPUrlKey
                                 ];
    
    return @{kSAPFieldsKey : fieldsParameter};
}

- (NSDictionary *)cachedResult {
    NSDictionary *result = nil;
    SAPUser *model = self.model;
    if (model.cached) {
        SAPUser *cachedModel = [NSKeyedUnarchiver unarchiveObjectWithFile:model.path];
        result = @{kSAPIDKey        : SAPNSNullIfNil(cachedModel.userId),
                   kSAPFirstNameKey : SAPNSNullIfNil(cachedModel.firstName),
                   kSAPLastNameKey  : SAPNSNullIfNil(cachedModel.lastName),
                   kSAPLargePictureAliasKey : @{
                                    kSAPDataKey : @{
                                            kSAPUrlKey : SAPNSNullIfNil(cachedModel.largeImageURL)}
                                                },
                   kSAPSquarePictureAliasKey : @{
                                     kSAPDataKey : @{
                                             kSAPUrlKey : SAPNSNullIfNil(cachedModel.smallImageURL)}
                                                },
                   kSAPGenderKey    : SAPNSNullIfNil(cachedModel.gender)
                   };
    }
    
    return [result JSONRepresentation];
}

- (void)fillModelWithResult:(NSDictionary *)result {
    SAPUser *user = self.model;
    
    user.userId = result[kSAPIDKey];
    user.firstName = result[kSAPFirstNameKey];
    user.lastName = result[kSAPLastNameKey];
    user.gender = result[kSAPGenderKey];
    
    NSString *urlString = result[kSAPLargePictureAliasKey][kSAPDataKey][kSAPUrlKey];
    user.largeImageURL = [NSURL URLWithString:urlString];
    
    urlString = result[kSAPSquarePictureAliasKey][kSAPDataKey][kSAPUrlKey];
    user.smallImageURL = [NSURL URLWithString:urlString];
}

@end
