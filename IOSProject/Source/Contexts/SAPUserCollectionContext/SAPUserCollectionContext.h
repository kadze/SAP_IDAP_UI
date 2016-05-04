//
//  SAPUserCollectionContext.h
//  IOSProject
//
//  Created by Andrey on 5/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookContext.h"

#import "SAPUser.h"

@interface SAPUserCollectionContext : SAPFacebookContext
@property (nonatomic, strong) SAPUser *user;

+ (instancetype)contextWithUser:(SAPUser *)user;

@end
