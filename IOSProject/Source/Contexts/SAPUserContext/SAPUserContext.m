//
//  SAPUserContext.m
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserContext.h"

#import "SAPUser.h"
#import "SAPCoreDataController.h"

#import "SAPJSONRepresentationImports.h"

#import "SAPNilToNSNullMacro.h"

#import "SAPGraphStringConstants.h"

@implementation SAPUserContext

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    SAPUser *user = self.model;
    
    return user.iD;
}

- (NSDictionary *)graphRequestParameters {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@,%@,%@{%@}",
                                 kSAPFirstNameKey,
                                 kSAPLastNameKey,
                                 kSAPSquarePictureWithAliasKey,
                                 kSAPUrlKey];
    
    return @{kSAPFieldsKey : fieldsParameter};
}

- (id)cachedResult {
   return self.model;
}

- (void)saveCache {   
    [SAPCoreDataController saveSharedMahagedObjectContext];
}

- (void)fillModelWithResult:(id)result {
    SAPUser *user = self.model;
    
    if (result == user) {
        return;
    }
    
    user.iD = result[kSAPIDKey];
    user.firstName = result[kSAPFirstNameKey];
    user.lastName = result[kSAPLastNameKey];
    user.smallImagePath = result[kSAPSquarePictureAliasKey][kSAPDataKey][kSAPUrlKey];
}

@end
