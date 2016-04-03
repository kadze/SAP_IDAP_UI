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

#import "UIAlertView+SAPExtensions.h"

#import "SAPDispatch.h"

@implementation SAPViewController
@dynamic mainView;

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
        self.mainView.loadingViewVisible = YES;
    });
}

- (void)modelDidFinishLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self updateViewControllerWithModel:model];
        self.mainView.loadingViewVisible = NO;
    });
}

- (void)modelDidFailLoading:(id)model withError:(NSError *)error{
    SAPDispatchAsyncOnMainQueue(^{
        self.mainView.loadingViewVisible = NO;
        if (error) {
            [UIAlertView showWithError:error];
        }
    });
}

- (void)modelDidUnload:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        self.mainView.loadingViewVisible = NO;
    });
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    
}

@end
