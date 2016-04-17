//
//  NSManagedObject+SAPExtensions.m
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSManagedObject+SAPExtensions.h"

#import "SAPClangMacro.h"

@implementation NSManagedObject (SAPExtensions)

#pragma mark -
#pragma mark Public

- (void)addCustomValue:(id)value inMutableSetForKey:(NSString *)key {
    [self handleCustomValue:value
         inMutableSetForKey:key
            withSetMutation:NSKeyValueUnionSetMutation
               withSelector:@selector(unionSet:)];
}

- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key {
    [self handleCustomValue:value
         inMutableSetForKey:key
            withSetMutation:NSKeyValueMinusSetMutation
               withSelector:@selector(minusSet:)];
}

#pragma mark -
#pragma mark Private

- (void)    handleCustomValue:(id)value
           inMutableSetForKey:(NSString *)key
              withSetMutation:(NSKeyValueSetMutationKind)mutation
                 withSelector:(SEL)selector
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:key
                withSetMutation:mutation
                   usingObjects:changedObjects];
    
    NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
    SAPClangDiagnosticPushOption("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
    [primitiveSet performSelector:selector withObject:changedObjects];
    SAPClangDiagnosticPopOption
    
    [self didChangeValueForKey:key
               withSetMutation:mutation
                  usingObjects:changedObjects];
}

@end
