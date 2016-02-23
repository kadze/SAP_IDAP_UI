//
//  SAPModel.m
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPModel.h"

@implementation SAPModel

- (void)notifyObserversOfReadyState {
    [self notifyObserversWithSelector:@selector(modelDidBecomeReadyToLoad:)];
}

- (void)notifyObserversOfLoading {
    [self notifyObserversWithSelector:@selector(modelDidBeginLoad:)];
}

- (void)notifyObserversOfFinishedLoad {
    [self notifyObserversWithSelector:@selector(modelDidFinishLoad:)];
}

- (void)notifyObserversOfCancelledLoad {
    [self notifyObserversWithSelector:@selector(modelDidCancelLoad:)];
}

- (void)notifyObserversOfFailedLoad {
    [self notifyObserversWithSelector:@selector(modelDidFailLoad:)];
}

@end

