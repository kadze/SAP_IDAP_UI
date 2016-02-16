//
//  SAPArrayModelChangeModel.h
//  IOSProject
//
//  Created by S A P on 2/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SAPArrayModelChangeModel : NSObject
@property (nonatomic, readonly) SAPChangeType   changeType;
@property (nonatomic, readonly) NSArray         *indexes;

+ (SAPArrayModelChangeModel *)modelWithChangeType:(SAPChangeType)changeType
                                          indexes:(NSArray *)indexes;

@end
