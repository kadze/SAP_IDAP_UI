//
//  SAPFacebookContext.m
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookContext.h"

#import "SAPModel.h"
#import "SAPDispatch.h"

@implementation SAPFacebookContext
@dynamic graphRequest;
@dynamic completionHandler;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self cancel];
}

#pragma mark -
#pragma mark Accessors

- (void)setConnection:(FBSDKGraphRequestConnection *)connection {
    if (_connection != connection) {
        [_connection cancel];
        _connection = connection;
        [connection start];
    }
}

#pragma mark -
#pragma mark Public

- (void)execute {
    SAPModel *model = self.model;
    @synchronized (model) {
        NSUInteger state = model.state;
        if (kSAPModelStateDidFinishLoading == state || kSAPModelStateWillLoad == state) {
            [model notifyObserversWithSelector:[model selectorForState:state]];
            
            return;
        }
        
        model.state = kSAPModelStateWillLoad;
    }

    SAPDispatchSyncOnDefaultQueue(^{
        [self performBackgroundExecution];
    });
}

- (void)cancel {
    self.connection = nil;
}

#pragma mark -
#pragma mark Private

- (void)performBackgroundExecution {
    FBSDKGraphRequestConnection *connection = [FBSDKGraphRequestConnection new];
    [connection addRequest:self.graphRequest completionHandler:[self completionHandler]];
    self.connection = connection;
}

@end
