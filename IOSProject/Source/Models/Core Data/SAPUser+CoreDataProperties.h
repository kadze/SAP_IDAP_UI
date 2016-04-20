//
//  SAPDBUser+CoreDataProperties.h
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SAPUser.h"

@interface SAPUser (CoreDataProperties)
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSSet    *friends;
@property (nonatomic, strong) NSSet    *images;

@end

@interface SAPUser (CoreDataGeneratedAccessors)

- (void)addFriend:(SAPUser *)value;
- (void)removeFriend:(SAPUser *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;
//
//- (void)addImage:(SAPDBImage *)value;
//- (void)removeImage:(SAPDBImage *)value;
//- (void)addImages:(NSSet *)values;
//- (void)removeImages:(NSSet *)values;

@end

