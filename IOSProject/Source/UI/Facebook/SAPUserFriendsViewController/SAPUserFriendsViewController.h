//
//  SAPUserFriendsViewController.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayViewController.h"

@class SAPUser;
@class SAPCompositeUserContext;

@interface SAPUserFriendsViewController : SAPArrayViewController
@property (nonatomic, strong) SAPUser                  *user;

@end
