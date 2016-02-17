//
//  SAPArrayIndexChangeModel.h
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeModel.h"


@interface SAPArrayIndexChangeModel : SAPCollectionChangeModel
@property (nonatomic, readonly) NSUInteger index;

+ (id)modelWithChangeType:(SAPChangeType)changeType
                    index:(NSUInteger)index;

@end
