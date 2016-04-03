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

#import "NSNull+SAPJSONNull.h"
#import "NSArray+SAPJSONArray.h"
#import "NSObject+SAPJSONObject.h"
#import "NSDictionary+SAPJSONDictionary.h"

#import "SAPGraphStringConstants.h"

#import "SAPNilVsNSNullSubstituteMacro.h"

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

- (NSDictionary *)cachedResult {
    NSDictionary *result = nil;
    SAPUser *model = self.model;
    if (model.cached) {
        SAPUser *cachedModel = [NSKeyedUnarchiver unarchiveObjectWithFile:model.path];
        id cachedModelUrl = cachedModel.largeImageURL.absoluteString;
        cachedModelUrl = (!cachedModelUrl) ? [NSNull new ]: cachedModelUrl;
        result = @{kSAPIDKey        : SAPNSNullIfNil(cachedModel.userId),
                   kSAPGenderKey    : SAPNSNullIfNil(cachedModel.gender),
                   kSAPPictureKey   : @{
                           kSAPDataKey : @{
                                   kSAPUrlKey : SAPNSNullIfNil(cachedModel.largeImageURL.absoluteString)}
                           }
                   };
    }
    
    return [result JSONRepresentation];
}

- (void)fillModelWithResult:(NSDictionary *)result {
    SAPUser *user = self.model;
    user.gender         = result[kSAPGenderKey];
    NSString *urlString = result[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
    user.largeImageURL  = [NSURL URLWithString:urlString];
}

@end
