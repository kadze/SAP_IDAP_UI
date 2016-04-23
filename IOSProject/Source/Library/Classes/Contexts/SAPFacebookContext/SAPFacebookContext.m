//
//  SAPFacebookContext.m
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookContext.h"

#import "SAPModel.h"
#import "SAPCoreDataController.h"

#import "UIAlertView+SAPExtensions.h"

#import "SAPCacheableModel.h"

#import "SAPOwnershipMacro.h"

#import "SAPDispatch.h"

@interface SAPFacebookContext ()
@property (nonatomic, readonly) FBSDKGraphRequestHandler completionHandler;
@property (nonatomic, readonly) FBSDKGraphRequest        *graphRequest;

- (void)performBackgroundExecution;
    
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
    }
}

- (FBSDKGraphRequest *)graphRequest {    
    return [[FBSDKGraphRequest alloc] initWithGraphPath:[self graphRequestPath]
                                             parameters:[self graphRequestParameters]];
}

- (FBSDKGraphRequestHandler)completionHandler {
    SAPWeakify(self);
    return ^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        SAPStrongifyAndReturnIfNil(self);
        SAPModel<SAPCacheableModel> *model = self.model;
        
        if (error) {
            NSDictionary *cachedResult = [self cachedResult];
            if (cachedResult) {
                result = cachedResult;
            } else {
                @synchronized (model) {
                    [model setState:kSAPModelStateDidFailLoading withObject:error];
                    
                    return;
                }
            }
        }
        
        [self fillModelWithResult:result];
        
        if (!error) {
            [self saveCache];
        }
        
        @synchronized (model) {
            model.state = kSAPModelStateDidFinishLoading;
        }
    };
}

#pragma mark -
#pragma mark Public

- (void)cancel {
    self.connection = nil;
}

- (void)stateUnsafeLoad {
    SAPWeakify(self);
    SAPDispatchAsyncOnDefaultQueue(^{
        SAPStrongifyAndReturnIfNil(self);
        [self performBackgroundExecution];
    });
}

- (void)cleanCacheInBackground {
//    SAPModel<SAPCacheableModel> *model = self.model;
//    if ([model respondsToSelector:@selector(cleanCache)]) {
//        SAPDispatchAsyncOnDefaultQueue(^{
//            [model cleanCache];
//        });
//    }
}

- (id)cachedResult {
    return nil;
}

- (void)saveCache {
    
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
    SAPWeakify(self);
    SAPDispatchAsyncOnMainQueue(^{
        SAPStrongifyAndReturnIfNil(self);
        self.connection = [self.graphRequest startWithCompletionHandler:self.completionHandler];
    });
}

@end
