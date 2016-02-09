//
//  SAPUsers.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPObservableObject.h"

@class SAPUser;

@interface SAPUsers : SAPObservableObject
@property (nonatomic, readonly) NSArray     *users;
@property (nonatomic, readonly) NSUInteger  count;

- (SAPUser *)objectAtIndex:(NSUInteger) index;
- (SAPUser *)objectAtIndexedSubscript:(NSUInteger)index;

@end
