//
//  UIWindow+SAPExtentions.m
//  IOSProject
//
//  Created by S A P on 2/4/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "CGGeometry+SAPExtentions.h"

static inline
CGPoint CGPointBySubstractingRects(CGRect minuend, CGRect subtrahend) {
    return CGPointMake(CGRectGetMaxX(minuend) - CGRectGetWidth(subtrahend),
                       CGRectGetMaxY(minuend) - CGRectGetHeight(subtrahend));
}
