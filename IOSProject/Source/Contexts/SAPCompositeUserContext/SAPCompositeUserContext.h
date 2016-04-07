//
//  SAPCompositeUserContext.h
//  IOSProject
//
//  Created by SAP on 4/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPContext.h"

#import "SAPModelObserver.h"

@class SAPUserContext;
@class SAPUserDetailContext;

@interface SAPCompositeUserContext : SAPContext <SAPModelObserver>
@property (nonatomic, readonly) SAPUserContext          *userContext;
@property (nonatomic, readonly) SAPUserDetailContext    *userDetailContext;

@end
