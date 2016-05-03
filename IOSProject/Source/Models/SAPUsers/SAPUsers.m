//
//  SAPData.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsers.h"

static NSString * const kSAPDescriptorKey = @"firstName";

@implementation SAPUsers

#pragma mark -
#pragma mark Public

- (NSArray *)fetchedResultsControllerSortDescriptors {
    return @[[NSSortDescriptor sortDescriptorWithKey:kSAPDescriptorKey ascending:YES]];
}

@end
