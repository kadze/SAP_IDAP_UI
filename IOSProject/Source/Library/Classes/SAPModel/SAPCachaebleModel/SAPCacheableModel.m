//
//  SAPCacheableModel.m
//  IOSProject
//
//  Created by S A P on 3/6/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCacheableModel.h"

@implementation SAPCacheableModel

@dynamic cached;
@dynamic path;

#pragma mark -
#pragma mark Accessors

- (BOOL)cached {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:self.path];
}

// to be overriden. each model has it's own cache path
- (NSString *)path {
    return nil;
}

@end
