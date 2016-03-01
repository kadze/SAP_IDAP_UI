//
//  NSObject+SAPAssociatedObjects.m
//  IOSProject
//
//  Created by S A P on 2/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSObject+SAPAssociatedObjects.h"

@implementation NSObject (SAPAssociatedObjects)

- (void)seAssociatedtObject:(id)value forKey:(void *)key withOption:(objc_AssociationPolicy)option {
    objc_setAssociatedObject(self, key, value, option);
}

- (id)associatedObjectForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

@end
