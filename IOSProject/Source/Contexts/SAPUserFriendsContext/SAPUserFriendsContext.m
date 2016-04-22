//
//  SAPUserFriendsContext.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserFriendsContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "SAPUser.h"
#import "SAPUsers.h"
#import "SAPCoreDataController.h"

#import "SAPJSONRepresentationImports.h"

#import "SAPGraphStringConstants.h"

#import "SAPNilToNSNullMacro.h"

@implementation SAPUserFriendsContext

#pragma mark -
#pragma mark Initializations And Deallocations

- (instancetype)initWithUser:(SAPUser *)user {
    self = [super init];
    self.user = user;
    
    return self;
}

#pragma mark -
#pragma mark Class Methods

+ (instancetype)contextWithUser:(SAPUser *)user {
    return [[self alloc] initWithUser:user];
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(SAPUser *)user {
    if (_user != user) {
        _user = user;
        
        self.model = user.friends;
    }
}

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    return self.user.userId;
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

- (NSDictionary *)cachedResult {
    NSDictionary *result = nil;
//    SAPUser *user = self.user;
//    if (user.cached) {
//        SAPUser *cachedUser = [NSKeyedUnarchiver unarchiveObjectWithFile:user.path];
//        
//        NSMutableArray *friendElements = [NSMutableArray new];
//        
//        for (SAPUser *friend in cachedUser.friends.objects) {
//            NSDictionary *friendElement = @{kSAPIDKey : SAPNSNullIfNil(friend.userId),
//                                            kSAPFirstNameKey : SAPNSNullIfNil(friend.firstName),
//                                            kSAPLastNameKey : SAPNSNullIfNil(friend.lastName),
//                                            kSAPPictureKey : @{
//                                                    kSAPDataKey : @{
//                                                            kSAPUrlKey : SAPNSNullIfNil(friend.smallImageURL)
//                                                            }
//                                                    }
//                                            };
//            
//            [friendElements addObject:friendElement];
//        }
//        
//        result = @{kSAPFriendsKey : @{kSAPDataKey : [friendElements copy]}};
//    }
    
    return [result JSONRepresentation];
}

- (void)fillModelWithResult:(NSDictionary *)result {
    NSArray *friendElements = result[kSAPFriendsKey][kSAPDataKey];

    NSManagedObjectContext *managedObjectContext = [SAPCoreDataController sharedManagedObjectContext];
    NSString *entityName = NSStringFromClass([SAPUser class]);
    
    SAPUser *user = self.user;
    
    for (id friendElement in friendElements) {
        SAPUser *friend = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                        inManagedObjectContext:managedObjectContext];
        friend.userId = friendElement[kSAPIDKey];
        friend.firstName = friendElement[kSAPFirstNameKey];
        friend.lastName = friendElement[kSAPLastNameKey];
        
//        NSString *urlString = friendElement[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
//        user.smallImageURL = [NSURL URLWithString:urlString];
        
        [user addFriend:friend];
    }
}

@end
