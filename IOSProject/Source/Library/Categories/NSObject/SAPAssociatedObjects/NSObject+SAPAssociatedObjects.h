//
//  NSObject+SAPAssociatedObjects.h
//  IOSProject
//
//  Created by S A P on 2/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (SAPAssociatedObjects)

- (void)setAssociatedtObject:(id)value forKey:(void *)key withOption:(objc_AssociationPolicy)option;
- (id)associatedObjectForKey:(void *)key;

@end
