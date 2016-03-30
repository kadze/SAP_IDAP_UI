//
//  SAPFacebookContext.m
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookContext.h"

#import "SAPModel.h"

#import "SAPOwnershipMacro.h"

#import "SAPDispatch.h"

@interface SAPFacebookContext ()
@property (nonatomic, readonly) FBSDKGraphRequestHandler completionHandler;

@property (nonatomic, readonly) FBSDKGraphRequest *graphRequest;

@end

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

- (FBSDKGraphRequest *)graphRequest {
    NSDictionary *parameters = [self graphRequestParameters];
    
    return [[FBSDKGraphRequest alloc] initWithGraphPath:[self graphRequestPath]
                                             parameters:parameters];
}

- (FBSDKGraphRequestHandler)completionHandler {
    SAPModel *model = self.model;
    SAPWeakify(self);
    return ^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        SAPStrongifyAndReturnIfNil(self);
        
        if (error) {
            @synchronized (model) {
                model.state = kSAPModelStateDidFailLoading;
                
                return;
            }
        }
        
        [self fillModelWithResult:result];
        
        @synchronized (model) {
            model.state = kSAPModelStateDidFinishLoading;
        };
    };
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

    SAPWeakify(self);
//    SAPDispatchAsyncOnDefaultQueue(^{
//        /doesn't work. doesn't call completion handler
    SAPDispatchSyncOnDefaultQueue(^{
        SAPStrongifyAndReturnIfNil(self);
        [self performBackgroundExecution];
    });
}

- (void)cancel {
    self.connection = nil;
}

- (void)fillModelWithResult:(NSDictionary *)result {
    
}

- (NSString *)graphRequestPath {
    return nil;
}

- (NSDictionary *)graphRequestParameters {
    return nil;
}

#pragma mark -
#pragma mark Private

- (void)performBackgroundExecution {
    FBSDKGraphRequestConnection *connection = [FBSDKGraphRequestConnection new];
    [connection addRequest:self.graphRequest completionHandler:self.completionHandler];
    self.connection = connection;
}

@end
