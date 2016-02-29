//
//  NSObject+SAPAssociatedObjects.m
//  IOSProject
//
//  Created by S A P on 2/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSObject+SAPAssociatedObjects.h"

#import <objc/runtime.h>

@implementation NSObject (SAPAssociatedObjects)

- (void)associateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)associateBoolValue:(BOOL)value withKey:(void *)key {
    NSNumber *number = [NSNumber numberWithBool:value];
    [self associateValue:number withKey:key];
}

- (BOOL)associatedBoolValueForKey:(void *)key {
    NSNumber *number = [self associatedValueForKey:key];
    
    return [number boolValue];
}

@end
