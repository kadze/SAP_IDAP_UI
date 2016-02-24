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

- (void)modelDidBeginLoad:(id)model;
- (void)modelDidFinishLoad:(id)model;
- (void)modelDidFailLoad:(id)model;
- (void)modelDidCancelLoad:(id)model;
- (void)modelDidBecomeReadyToLoad:(id)model;

@end
