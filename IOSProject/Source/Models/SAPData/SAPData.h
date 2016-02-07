//
//  SAPData.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPData : NSObject
@property (nonatomic, copy)             NSString *randomString;
@property (nonatomic, strong, readonly) NSArray  *strings;

- (void)fillWithRandomStrings;

@end
