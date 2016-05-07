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
//#import "SAPDBImage.h"

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
@dynamic dbFriends;
@dynamic smallImagePath;
@dynamic largeImagePath;

@dynamic smallImageURL;
@dynamic largeImageURL;
@dynamic smallImageModel;
@dynamic largeImageModel;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    self.friends = [[SAPUsers alloc] initWithFetchedResultsControllerForContext:(NSManagedObjectContext *)context
                                                                         entity:(NSEntityDescription *)entity];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)addFriend:(SAPUser *)value {
    [self addCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(dbFriends))];
    [self.friends addObject:value];
}

- (void)removeFriend:(SAPUser *)value {
    [self removeCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(dbFriends))];
}

- (SAPImageModel *)smallImageModel {
    return [SAPImageModel imageWithUrl:self.smallImageURL];
}

- (SAPImageModel *)largeImageModel {
    return [SAPImageModel imageWithUrl:self.largeImageURL];
}

- (NSURL *)smallImageURL {
    return [NSURL URLWithString:self.smallImagePath];
}

- (NSURL *)largeImageURL {
    return [NSURL URLWithString:self.largeImagePath];
}

@end
