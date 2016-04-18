//
//  SAPManagedObject.m
//  IOSProject
//
//  Created by Andrey on 4/19/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPManagedObject.h"

#import "SAPObservableObject.h"

@interface SAPManagedObject ()
@property (nonatomic, strong) SAPObservableObject *observableObject;

@end

@implementation SAPManagedObject
@synthesize observableObject = _observableObject;

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    self.observableObject = [[SAPObservableObject alloc] initWithTarget:self];
    
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    id observableObject = self.observableObject;
    if ([observableObject respondsToSelector:aSelector]) {
        return observableObject;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

@end
