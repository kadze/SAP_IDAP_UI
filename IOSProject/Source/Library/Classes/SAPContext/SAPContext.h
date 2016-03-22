//
//  SAPContext.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@class FBSDKGraphRequest;

@interface SAPContext : NSObject
@property (nonatomic, strong) id model;

+ (instancetype)contextWithModel:(id)model;

- (instancetype)initWithModel:(id)model;

- (void)execute;
- (void)cancel;

//- (FBSDKGraphRequest *)graphRequest:(NSString *)graphPath;

@end
