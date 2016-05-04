//
//  SAPUserCollectionContext.m
//  IOSProject
//
//  Created by Andrey on 5/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserCollectionContext.h"

#import "SAPCoreDataController.h"

@implementation SAPUserCollectionContext

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

@end
