//
//  SAPData.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsers.h"

#import "SAPUser.h"

@implementation SAPUsers

#pragma mark -
#pragma mark SAPCacheableModel

- (void)cleanCache {
    for (SAPUser *user in self.objects) {
        [user cleanCache];
    }
}

@end
