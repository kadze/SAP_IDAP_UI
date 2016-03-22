//
//  SAPContext.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPContext.h"

@implementation SAPContext

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithModel:(id)model {
    self = [super init];
    self.model = model;
    
    return self;
}

#pragma mark -
#pragma mark Class Methods

+ (instancetype)contextWithModel:(id)model {
    return [[self alloc] initWithModel:model];
}

#pragma mark -
#pragma mark Public

- (void)execute {
    return;
}

- (void)cancel {
    return;
}

//- (FBSDKGraphRequest *)graphRequest:(NSString *)graphPath {
//    return [[FBSDKGraphRequest alloc] initWithGraphPath:graphPath parameters:nil];
//}

@end
