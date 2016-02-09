//
//  UINib+SAPExtentions.m
//  IOSProject
//
//  Created by S A P on 2/9/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UINib+SAPExtentions.h"

@implementation UINib (SAPExtentions)

+ (UINib *)nibWithClass:(Class)aClass {
    return [self nibWithClass:aClass bundle:nil];
}

+ (UINib *)nibWithClass:(Class)aClass bundle:(NSBundle *)bundle {
    return [self nibWithNibName:NSStringFromClass(aClass) bundle:bundle];
}

- (id)getObjectOfClass:(Class)aClass {
    NSArray *objects = [self instantiateWithOwner:nil options:nil];
    for (id object in objects) {
        if ([object isKindOfClass:aClass]) {
            return object;
        }
    }

    return nil;
}

@end
