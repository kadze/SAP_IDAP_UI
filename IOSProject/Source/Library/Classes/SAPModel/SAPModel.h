//
//  SAPModel.h
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPObservableObject.h"
#import "SAPModelObserver.h"

@interface SAPModel : SAPObservableObject
- (void)notifyObserversOfReadyState;
- (void)notifyObserversOfLoading;
- (void)notifyObserversOfFinishedLoad;
- (void)notifyObserversOfCancelledLoad;
- (void)notifyObserversOfFailedLoad;

@end
