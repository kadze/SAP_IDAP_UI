//
//  SAPSetters.m
//  IOSProject
//
//  Created by Andrey on 4/15/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSetters.h"

#import "SAPContext.h"

#pragma mark -
#pragma mark Public Implementations

void SAPSetContext(SAPContext *__strong* context, id value) {
    if (*context != value) {
        [*context cancel];
        *context = value;
        [*context execute];
    }
}

