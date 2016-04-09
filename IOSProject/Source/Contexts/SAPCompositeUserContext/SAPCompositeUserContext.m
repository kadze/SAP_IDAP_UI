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

@interface SAPCompositeUserContext ()
@property (nonatomic, strong) SAPUserDetailContext  *userDetailContext;
@property (nonatomic, strong) SAPUserFriendsContext *userFriendsContext;

@end

@implementation SAPCompositeUserContext

#pragma mark -
#pragma mark Public

- (void)execute {
    SAPUser *user = self.model;
    self.userDetailContext = [SAPUserDetailContext contextWithModel:user];
    [self.userDetailContext execute];
    self.userFriendsContext = [SAPUserFriendsContext contextWithModel:user.friends];
    [self.userFriendsContext execute];
}

@end
