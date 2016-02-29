//
//  NSObject+SAPAssociatedObjects.h
//  IOSProject
//
//  Created by S A P on 2/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SAPAssociatedObjects)

- (void)associateValue:(id)value withKey:(void *)key;
- (id)associatedValueForKey:(void *)key;

- (void)associateBoolValue:(BOOL)value withKey:(void *)key;
- (BOOL)associatedBoolValueForKey:(void *)key;

@end
