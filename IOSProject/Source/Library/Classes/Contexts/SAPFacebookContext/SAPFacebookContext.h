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

- (NSString *)graphRequestPath;
- (NSDictionary *)graphRequestParameters;
- (void)fillModelWithResult:(NSDictionary *)result;

@end
