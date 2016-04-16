//
//  SAPDBUser+CoreDataProperties.m
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SAPDBUser+CoreDataProperties.h"

#import "NSManagedObject+SAPExtensions.h"

@implementation SAPDBUser (CoreDataProperties)

@dynamic firstName;
@dynamic gender;
@dynamic lastName;
@dynamic userId;
@dynamic friends;
@dynamic images;

#pragma mark -
#pragma mark Accessors

- (void)addFriend:(SAPDBUser *)value {
    [self addCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(friends))];
}

- (void)removeFriend:(SAPDBUser *)value {
    [self removeCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(friends))];
}

- (void)addImage:(SAPDBImage *)value {
    [self addCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(images))];
}

- (void)removeImage:(SAPDBImage *)value {
    [self removeCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(images))];
}

@end
