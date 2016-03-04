//
//  NSObject+SAPAssociatedObjects.h
//  IOSProject
//
//  Created by S A P on 2/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, SAPObjCAssociationPolicy)  {
    kSAPAssociationAssign = OBJC_ASSOCIATION_ASSIGN,
    kSAPAssociationNonatomicRetain = OBJC_ASSOCIATION_RETAIN_NONATOMIC,
    kSAPAssociationNonatomicCopy = OBJC_ASSOCIATION_COPY_NONATOMIC,
    kSAPAssociationRetain = OBJC_ASSOCIATION_RETAIN,
    kSAPAssociationCopy = OBJC_ASSOCIATION_COPY
};

@interface NSObject (SAPAssociatedObjects)

- (void)setAssociatedtObject:(id)value forKey:(void *)key withOption:(SAPObjCAssociationPolicy)option;
- (id)associatedObjectForKey:(void *)key;

@end
