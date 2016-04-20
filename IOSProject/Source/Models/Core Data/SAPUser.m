//
//  SAPDBUser.m
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUser.h"

#import "SAPUsers.h"
#import "SAPModel.h"
#import "SAPDBImage.h"

#import "NSManagedObject+SAPExtensions.h"

@interface SAPUser ()
@property (nonatomic, strong) SAPUsers *friends;

@end

@implementation SAPUser

@synthesize friends = _friends;

@dynamic userId;
@dynamic firstName;
@dynamic lastName;
@dynamic gender;
//@dynamic dbFriends;

#pragma mark -
#pragma mark Accessors

//- (void)addFriend:(SAPUser *)value {
//    [self addCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(dbFriends))];
//}
//
//- (void)removeFriend:(SAPUser *)value {
//    [self removeCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(dbFriends))];
//}

#pragma mark -
#pragma mark Public

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    self.friends = [SAPUsers new];
    
    return self;
}

@end
