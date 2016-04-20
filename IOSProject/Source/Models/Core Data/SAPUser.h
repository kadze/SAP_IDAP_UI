//
//  SAPDBUser.h
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "SAPManagedObject.h"
#import "SAPImageModel.h"

//@class SAPDBImage;
@class SAPUsers;

@interface SAPUser : SAPManagedObject
@property (nonatomic, copy)     NSString        *userId;
@property (nonatomic, copy)     NSString        *firstName;
@property (nonatomic, copy)     NSString        *lastName;
@property (nonatomic, copy)     NSString        *gender;
//@property (nonatomic, strong)   NSSet           *dbFriends;


//@property (nonatomic, readonly) SAPImageModel    *smallImageModel;
//@property (nonatomic, copy)     NSURL            *smallImageURL;
//
//@property (nonatomic, readonly) SAPImageModel    *largeImageModel;
//@property (nonatomic, copy)     NSURL            *largeImageURL;
//
@property (nonatomic, readonly) SAPUsers         *friends;

@end

//@interface SAPUser (CoreDataGeneratedAccessors)
//
//- (void)addFriend:(SAPUser *)value;
//- (void)removeFriend:(SAPUser *)value;
//- (void)addDbFriends:(NSSet *)values;
//- (void)removeDbFriends:(NSSet *)values;
//
//@end

//#import "SAPDBUser+CoreDataProperties.h"
