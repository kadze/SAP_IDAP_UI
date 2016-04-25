//
//  SAPUserDetailContext.m
//  IOSProject
//
//  Created by SAP on 3/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserDetailContext.h"

#import "SAPUser.h"

#import "SAPJSONRepresentationImports.h"

#import "SAPGraphStringConstants.h"

#import "SAPNilToNSNullMacro.h"

@implementation SAPUserDetailContext

#pragma mark -
#pragma mark Public

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

- (void)fillModelWithResult:(id)result {
    
    [super fillModelWithResult:result];
    
    SAPUser *user = self.model;
    
    if (result == user) {
        return;
    }
    
    user.gender = result[kSAPGenderKey];
    user.largeImagePath = result[kSAPLargePictureAliasKey][kSAPDataKey][kSAPUrlKey];
}

@end
