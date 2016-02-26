//
//  SAPModelObserver.h
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAPModelObserver <NSObject>

@optional

- (void)modelWillLoad:(id)model;
- (void)modelDidFinishLoad:(id)model;
- (void)modelDidFailLoad:(id)model;
- (void)modelDidBecomeUnloaded:(id)model;

@end
