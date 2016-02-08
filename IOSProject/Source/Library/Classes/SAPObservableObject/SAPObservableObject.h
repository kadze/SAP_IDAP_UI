//
//  SAPObservableObject.h
//  MacCourse
//
//  Created by S A P on 12/10/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPObservableObject : NSObject
@property (nonatomic, assign)   NSUInteger  state;
@property (nonatomic, readonly) NSArray     *observers;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (void)removeObserversFromArray:(NSArray *)array;
- (void)addObserversFromArray:(NSArray *)array;

- (void)notifyObserversWithSelector:(SEL)selector;
- (void)notifyObserversWithSelector:(SEL)selector withObject:(id)object;

- (SEL)selectorForState:(NSUInteger)state;

@end
