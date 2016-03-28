//
//  SAPUserFriendsContext.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookContext.h"

@class SAPUser;

@interface SAPUserFriendsContext : SAPFacebookContext;
@property (nonatomic, strong) SAPUser *user;

@end
