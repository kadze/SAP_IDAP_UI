//
//  SAPDBImage+CoreDataProperties.m
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SAPDBImage+CoreDataProperties.h"

#import "NSManagedObject+SAPExtensions.h"

@implementation SAPDBImage (CoreDataProperties)

@dynamic path;
@dynamic size;
@dynamic users;

#pragma mark -
#pragma mark Accessors

- (void)addUser:(SAPDBUser *)value {
    [self addCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(users))];
}

- (void)removeUser:(SAPDBUser *)value {
    [self removeCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(users))];
}

@end
