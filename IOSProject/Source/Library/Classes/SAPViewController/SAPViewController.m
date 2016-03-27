//
//  SAPViewController.m
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPViewController.h"

#import "SAPView.h"
#import "SAPContext.h"

#import "SAPDispatch.h"

@implementation SAPViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.context = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setContext:(SAPContext *)context{
    if (_context != context) {
        [_context cancel];
        _context = context;
        [context execute];
    }
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelWillLoad:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        self.baseView.loadingViewVisible = YES;
    });
}

- (void)modelDidFinishLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self updateViewControllerWithModel:model];
        self.baseView.loadingViewVisible = NO;
    });
}

- (void)modelDidFailLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        self.baseView.loadingViewVisible = NO;
    });
}

- (void)modelDidUnload:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        self.baseView.loadingViewVisible = NO;
    });
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    
}

@end
