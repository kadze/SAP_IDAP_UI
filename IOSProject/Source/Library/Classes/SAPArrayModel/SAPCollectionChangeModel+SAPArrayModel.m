//
//  SAPCollectionChangeModel+SAPArrayModel.m
//  IOSProject
//
//  Created by S A P on 2/18/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeModel+SAPArrayModel.h"

#import "SAPArrayIndexChangeModel.h"
#import "SAPArrayDoubleIndexChangeModel.h"

@implementation SAPCollectionChangeModel (SAPArrayModel)

//SAPArrayIndexChangeModel

+ (instancetype)additionModelWithIndex:(NSUInteger)index {
    return [SAPArrayIndexChangeModel modelWithChangeType:kSAPChangeTypeObjectAdded index:index];
}

+ (instancetype)insertionModelWithIndex:(NSUInteger)index {
    return [SAPArrayIndexChangeModel modelWithChangeType:kSAPChangeTypeObjectInserted index:index];
}

+ (instancetype)removalModelWithIndex:(NSUInteger)index {
    return [SAPArrayIndexChangeModel modelWithChangeType:kSAPChangeTypeObjectRemoved index:index];
}

+ (instancetype)replacementModelWithIndex:(NSUInteger)index {
    return [SAPArrayIndexChangeModel modelWithChangeType:kSAPChangeTypeObjectReplaced index:index];
}

//SAPArrayDoubleIndexChangeModel

+ (instancetype)movingModelFromIndex:(NSUInteger)fromIndex
                             toIndex:(NSUInteger)toIndex {
    return [SAPArrayDoubleIndexChangeModel modelWithChangeType:kSAPChangeTypeObjectMoved
                                                         index:fromIndex
                                                       toIndex:toIndex];
}

+ (instancetype)exchangingModelAtIndex:(NSUInteger)index
                      withModelAtIndex:(NSUInteger)toIndex {
    return [SAPArrayDoubleIndexChangeModel modelWithChangeType:kSAPChangeTypeObjectExchanged
                                                         index:index
                                                       toIndex:toIndex];
}


@end
