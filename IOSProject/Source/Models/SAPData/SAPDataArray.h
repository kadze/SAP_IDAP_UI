//
//  SAPData.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSUInteger const kSAPArraySize = 100;

@class SAPDataElement;

@interface SAPDataArray : NSObject
@property (nonatomic, strong, readonly) NSArray     *dataElements;
@property (nonatomic, readonly)         NSUInteger  count;

- (void)fillWithDataElements;

- (SAPDataElement *)objectAtIndex:(NSUInteger) index;
- (SAPDataElement *)objectAtIndexedSubscript:(NSUInteger)index;

@end
