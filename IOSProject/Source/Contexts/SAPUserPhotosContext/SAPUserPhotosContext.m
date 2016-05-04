//
//  SAPUserPhotosContext.m
//  IOSProject
//
//  Created by Andrey on 5/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserPhotosContext.h"

#import "SAPCoreDataController.h"

#import "SAPJSONRepresentationImports.h"

#import "SAPGraphStringConstants.h"

@implementation SAPUserPhotosContext

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    return self.user.iD;
}

- (NSDictionary *)graphRequestParameters {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@{%@,%@,%@{%@}}",
                                 kSAPFriendsKey,
                                 kSAPFirstNameKey,
                                 kSAPLastNameKey,
                                 kSAPSquarePictureKey,
                                 kSAPUrlKey];
    
    return @{kSAPFieldsKey : fieldsParameter};
}

- (id)cachedResult {
    return self.user.dbFriends;
}

- (void)saveCache {
    [SAPCoreDataController saveSharedMahagedObjectContext];
}

- (void)fillModelWithResult:(id)result {
//    SAPUser *user = self.user;
//    NSSet *cachedFriends = user.dbFriends;
//    
//    if (result == cachedFriends) {
//        SAPUsers *friends = user.friends;
//        
//        for (SAPUser *friend in cachedFriends) {
//            [friends addObject:friend];
//        }
//    } else {
//        NSArray *friendElements = result[kSAPFriendsKey][kSAPDataKey];
//        
//        NSManagedObjectContext *managedObjectContext = [SAPCoreDataController sharedManagedObjectContext];
//        NSString *entityName = NSStringFromClass([SAPUser class]);
//        
//        //remove old friends
//        [user removeDbFriends:user.dbFriends];
//        
//        //fill with new friends
//        for (id friendElement in friendElements) {
//            SAPUser *friend = [NSEntityDescription insertNewObjectForEntityForName:entityName
//                                                            inManagedObjectContext:managedObjectContext];
//            friend.iD = friendElement[kSAPIDKey];
//            friend.firstName = friendElement[kSAPFirstNameKey];
//            friend.lastName = friendElement[kSAPLastNameKey];
//            friend.smallImagePath = friendElement[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
//            
//            [user addFriend:friend];
//        }
//    }
}

@end
