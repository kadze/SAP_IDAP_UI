//
//  SAPViewController.h
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPContext;
@class SAPView;

@interface SAPViewController : UIViewController
@property (nonatomic, readonly) SAPView *baseView;
@property (nonatomic, strong) SAPContext *context;

- (void)finishModelLoading;

@end
