//
//  SAPUserContext.m
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserContext.h"

#import "SAPUser.h"

#import "SAPGraphStringConstants.h"

#import "SAPNilVsNSNullSubstituteMacro.h"

@implementation SAPUserContext

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    return kSAPUserGraphPath;
}

- (NSDictionary *)graphRequestParameters {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@,%@,%@{%@}",
                                 kSAPFirstNameKey,
                                 kSAPLastNameKey,
                                 kSAPPictureKey,
                                 kSAPUrlKey];
    
    return @{kSAPFieldsKey : fieldsParameter};
}

- (NSDictionary *)cachedResult {
    NSDictionary *result = nil;
    SAPUser *model = self.model;
    if (model.cached) {
        SAPUser *cachedModel = [NSKeyedUnarchiver unarchiveObjectWithFile:model.path];
        result = @{kSAPIDKey : cachedModel.userId,
                   kSAPFirstNameKey : cachedModel.firstName,
                   kSAPLastNameKey : cachedModel.lastName,
                   kSAPPictureKey : @{
                           kSAPDataKey : @{
                                   kSAPUrlKey : cachedModel.imageURL.absoluteString}
                           }
                   };
    }
    
    return result;
}

- (void)fillModelWithResult:(NSDictionary *)result {
    SAPUser *user = self.model;
    user.userId =       SAPNilIfNSNull(result[kSAPIDKey]);
    user.firstName =    SAPNilIfNSNull(result[kSAPFirstNameKey]);
    user.lastName =     SAPNilIfNSNull(result[kSAPLastNameKey]);
    NSString *urlString = SAPNilIfNSNull(result[kSAPPictureKey][kSAPDataKey][kSAPUrlKey]);
    user.imageURL =     SAPNilIfNSNull([NSURL URLWithString:urlString]);
}

@end
