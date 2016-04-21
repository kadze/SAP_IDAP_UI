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

@interface SAPUserFriendsContext ()
@property (nonatomic, strong) NSManagedObjectID *userManagedObjectID;

@end

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
        
        self.userManagedObjectID = user.objectID;
        self.model = user.friends;
    }
}

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
//    //restore managedObject in other thread
//    SAPCoreDataController *controller = [[SAPCoreDataController alloc] init];
//    NSManagedObjectContext *managedObjectContext = controller.managedObjectContext;
//    SAPUser *user = [managedObjectContext objectWithID:self.userManagedObjectID];
//    
//    return user.userId;
    
    NSString *result = self.user.userId;
    return result;
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
//    SAPUsers *friends = self.model;
    NSArray *friendElements = result[kSAPFriendsKey][kSAPDataKey];

    SAPCoreDataController *controller = [[SAPCoreDataController alloc] init];
    NSManagedObjectContext *managedObjectContext = controller.managedObjectContext;
    NSString *entityName = NSStringFromClass([SAPUser class]);
    
    SAPUser *modelUser = [managedObjectContext objectWithID:self.userManagedObjectID];
    SAPUsers *friends = modelUser.friends;
    
    [friends performBlockWithoutNotification:^{
        for (id friendElement in friendElements) {
            SAPUser *user = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                          inManagedObjectContext:managedObjectContext];
            user.userId = friendElement[kSAPIDKey];
            user.firstName = friendElement[kSAPFirstNameKey];
            user.lastName = friendElement[kSAPLastNameKey];
            
//            NSString *urlString = friendElement[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
//            user.smallImageURL = [NSURL URLWithString:urlString];
            
//            [friends addObject:user];
            int a = friends.count;
            [modelUser addFriend:user];
        }
    }];
    
    NSError *error = nil;
    [managedObjectContext save:&error];
}

@end
