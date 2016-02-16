//
//  SAPArrayModelObserver.h
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAPArrayModelChangeModel;
@class SAPArrayModel;

@protocol SAPArrayModelObserver <NSObject>

- (void)didChanged:(SAPArrayModel *)arrayModel withModel:(SAPArrayModelChangeModel *)changeModel;

@end
