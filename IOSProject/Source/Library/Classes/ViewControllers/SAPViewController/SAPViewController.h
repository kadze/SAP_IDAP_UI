//
//  SAPViewController.h
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIViewController.h>

#import "SAPModelObserver.h"

@class SAPContext;
@class SAPView;

@interface SAPViewController : UIViewController <SAPModelObserver>
@property (nonatomic, readonly) SAPView    *mainView;
@property (nonatomic, strong)   SAPContext *context;

//this method should be overriden in subclasses
- (void)updateViewControllerWithModel:(id)model;

@end
