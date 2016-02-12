//
//  SAPArrayModel.h
//  IOSProject
//
//  Created by S A P on 2/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPObservableObject.h"

//typedef NS_ENUM (NSUInteger, SAPUsersState) {
//    kSAPUsersSatateDefault,
//    kSAPUsersSatateUserDidBecomeDeleted,
//    kSAPUsersSatateUserDidBecomeAdded,
//    kSAPUsersSatateUserDidBecomeReplaced
//};


@interface SAPArrayModel : SAPObservableObject
@property (nonatomic, readonly) NSArray     *objects;
@property (nonatomic, readonly) NSUInteger  count;

- (id)objectAtIndex:(NSUInteger) index;
- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;

@end
