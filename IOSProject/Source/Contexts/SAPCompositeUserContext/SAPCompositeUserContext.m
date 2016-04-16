//
//  SAPCompositeUserContext.m
//  IOSProject
//
//  Created by SAP on 4/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCompositeUserContext.h"

#import "SAPUser.h"
#import "SAPUserDetailContext.h"
#import "SAPUserFriendsContext.h"

#import "SAPSetters.h"

@interface SAPCompositeUserContext ()
@property (nonatomic, strong) SAPUserDetailContext  *userDetailContext;
@property (nonatomic, strong) SAPUserFriendsContext *userFriendsContext;

@end

@implementation SAPCompositeUserContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.userDetailContext = nil;
    self.userFriendsContext = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setUserDetailContext:(SAPUserDetailContext *)userDetailContext {
    SAPContextIvarSetValue(&_userDetailContext, userDetailContext);
}

-(void)setUserFriendsContext:(SAPUserFriendsContext *)userFriendsContext {
    SAPContextIvarSetValue(&_userFriendsContext, userFriendsContext);
}

#pragma mark -
#pragma mark Public

- (void)execute {
    SAPUser *user = self.model;
    self.userDetailContext = [SAPUserDetailContext contextWithModel:user];
    self.userFriendsContext = [SAPUserFriendsContext contextWithUser:user];
}

@end
