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

@interface SAPUserContext ()
@property (nonatomic, strong) NSManagedObjectID *userManagedObjectID;

@end

@implementation SAPUserContext

#pragma mark -
#pragma mark Accessors

- (void)setModel:(SAPUser *)model {
    [super setModel:model];
    
    self.userManagedObjectID = model.objectID;
}

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    //restore managedObject in other thread
//    SAPCoreDataController *controller = [[SAPCoreDataController alloc] init];
//    NSManagedObjectContext *managedObjectContext = controller.managedObjectContext;
//    SAPUser *user = [managedObjectContext objectWithID:self.userManagedObjectID];
//    
//    return user.userId;
    
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
    
    /*
    SAPCoreDataController *controller = [[SAPCoreDataController alloc] init];
    NSManagedObjectContext *managedObjectContext = controller.managedObjectContext;
    SAPUser *user = [managedObjectContext objectWithID:self.userManagedObjectID];
    */
    
    user.userId = result[kSAPIDKey];
    user.firstName = result[kSAPFirstNameKey];
    user.lastName = result[kSAPLastNameKey];
    
//    NSString *urlString = result[kSAPSquarePictureAliasKey][kSAPDataKey][kSAPUrlKey];
//    user.smallImageURL = [NSURL URLWithString:urlString];
    
    /*
    NSError *error = nil;
    [managedObjectContext save:&error];
     */
}

@end
