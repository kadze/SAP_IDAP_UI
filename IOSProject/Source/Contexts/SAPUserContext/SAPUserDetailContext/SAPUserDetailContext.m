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

- (NSDictionary *)cachedResult {
    NSMutableDictionary *result = nil;
    
    NSDictionary *superResult = [super cachedResult];

    [result addEntriesFromDictionary:superResult];

    SAPUser *cachedModel = self.model;
        NSDictionary *additionalResult = @{
//                                           kSAPLargePictureAliasKey : @{
//                                                   kSAPDataKey : @{
//                                                           kSAPUrlKey : SAPNSNullIfNil(cachedModel.largeImageURL)}
//                                                   },
                                           kSAPGenderKey            : SAPNSNullIfNil(cachedModel.gender)
                                           };
        
        [result addEntriesFromDictionary:additionalResult];
//    }

    return [result JSONRepresentation];
}

- (void)fillModelWithResult:(NSDictionary *)result {
    [super fillModelWithResult:result];
    
    SAPUser *user = self.model;
    
    user.gender = result[kSAPGenderKey];
    
//    NSString *urlString = result[kSAPLargePictureAliasKey][kSAPDataKey][kSAPUrlKey];
//    user.largeImageURL = [NSURL URLWithString:urlString];
}

@end
