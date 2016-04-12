//
//  SAPFacebookContext.h
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPContext.h"

@interface SAPFacebookContext : SAPContext
@property (nonatomic, strong) FBSDKGraphRequestConnection *connection;

//this methods should be overriden in subclasses
- (NSString *)graphRequestPath;
- (NSDictionary *)graphRequestParameters;

- (id)cachedResult;
- (void)fillModelWithResult:(NSDictionary *)result;

@end
