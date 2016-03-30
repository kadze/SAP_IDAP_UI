//
//  SAPModelKeeper.h
//  IOSProject
//
//  Created by SAP on 3/27/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAPModel;

@protocol SAPModelOwner <NSObject>
@property (nonatomic, strong) SAPModel *model;

@end
