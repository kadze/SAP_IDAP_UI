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

@interface SAPUser ()
@property (nonatomic, strong) SAPModel *model;
@property (nonatomic, strong) SAPUsers *friends;

@end

@implementation SAPUser

@synthesize model = _model;
@synthesize friends = _friends;

@dynamic userId;
@dynamic firstName;
@dynamic gender;
@dynamic lastName;

#pragma mark -
#pragma mark Public

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    self.model = [[SAPModel alloc] initWithTarget:self];
    self.friends = [SAPUsers new];
    
    return self;
}


#pragma mark -
#pragma mark Message Forwarding

- (id)forwardingTargetForSelector:(SEL)aSelector {
    id model = self.model;
    if ([model respondsToSelector:aSelector]) {
        return model;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

- (void)addObserver:(id)observer {
    [self.model addObserver:observer];
}

- (void)removeObserver:(id)observer {
    [self.model removeObserver:observer];
}

@end
