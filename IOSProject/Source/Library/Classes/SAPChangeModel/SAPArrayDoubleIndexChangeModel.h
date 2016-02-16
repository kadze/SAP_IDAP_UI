//
//  SAPArrayDoubleIndexChangeModel.h
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayIndexChangeModel.h"

@interface SAPArrayDoubleIndexChangeModel : SAPArrayIndexChangeModel
@property (nonatomic, readonly) NSUInteger toIndex;

+ (id)modelWithChangeType:(SAPChangeType)changeType
                    index:(NSUInteger)fromIndex
                  toIndex:(NSUInteger)toIndex;

@end
