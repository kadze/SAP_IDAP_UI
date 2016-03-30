//
//  SAPViewController.h
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPModelObserver.h"

@class SAPContext;
@class SAPView;

@interface SAPViewController : UIViewController <SAPModelObserver>
@property (nonatomic, readonly) SAPView    *baseView;
@property (nonatomic, strong)   SAPContext *context;

- (void)updateViewControllerWithModel:(id)model;

@end
