//
//  SAPUsers.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPObservableObject.h"

static NSUInteger const kSAPArraySize = 100;

@class SAPUser;

@interface SAPUsers : SAPObservableObject
@property (nonatomic, strong, readonly) NSArray     *dataElements;
@property (nonatomic, readonly)         NSUInteger  count;

- (void)fillWithDataElements;

- (SAPUser *)objectAtIndex:(NSUInteger) index;
- (SAPUser *)objectAtIndexedSubscript:(NSUInteger)index;

@end
