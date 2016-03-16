//
//  SAPContext.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPContext : NSObject
@property (nonatomic, retain) id model;

- (void)execute;
- (void)cancel;

@end
