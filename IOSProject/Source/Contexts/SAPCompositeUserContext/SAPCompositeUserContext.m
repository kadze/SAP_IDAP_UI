//
//  SAPCompositeUserContext.m
//  IOSProject
//
//  Created by SAP on 4/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCompositeUserContext.h"

#import "SAPUser.h"
#import "SAPUserContext.h"
#import "SAPUserDetailContext.h"

#import "SAPOwnershipMacro.h"

#import "SAPDispatch.h"

@interface SAPCompositeUserContext ()
@property (nonatomic, strong) SAPUserContext          *userContext;
@property (nonatomic, strong) SAPUserDetailContext    *userDetailContext;

@end

@implementation SAPCompositeUserContext

#pragma mark -
#pragma mark Public

- (void)stateUnsafeLoad {
    SAPWeakify(self);
    SAPDispatchAsyncOnDefaultQueue(^{
        SAPStrongifyAndReturnIfNil(self);
        SAPUser *user = self.model;
        [user addObserver:self];
        
        self.userContext = [SAPUserContext contextWithModel:user];
        [self.userContext stateUnsafeLoad];
    });
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelDidFinishLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [model removeObserver:self];
        self.userDetailContext = [SAPUserDetailContext contextWithModel:model];
        [self.userDetailContext stateUnsafeLoad];
    });
}

@end
