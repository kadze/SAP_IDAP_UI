//
//  SAPFacebookLoginContext.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPContext.h"

@class SAPLoginViewController;

@interface SAPFacebookLoginContext : SAPContext
@property (nonatomic, weak) SAPLoginViewController *controller;

@end
