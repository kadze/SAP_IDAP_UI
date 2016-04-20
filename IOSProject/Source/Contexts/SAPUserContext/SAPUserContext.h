//
//  SAPUserContext.h
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookContext.h"

@class NSManagedObjectID;

@interface SAPUserContext : SAPFacebookContext
@property (nonatomic, readonly) NSManagedObjectID *userManagedObjectID;

@end
