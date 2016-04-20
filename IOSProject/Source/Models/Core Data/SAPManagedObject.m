//
//  SAPManagedObject.m
//  IOSProject
//
//  Created by Andrey on 4/19/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPManagedObject.h"

#import <CoreData/CoreData.h>

#import "SAPCoreDataController.h"
#import "SAPObservableObject.h"

#import "UIAlertView+SAPExtensions.h"

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

//- (instancetype)cachedObject {
//    SAPCoreDataController *controller = [[SAPCoreDataController alloc] init];
//    NSManagedObjectContext *managedObjectContext = controller.managedObjectContext;
//    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
//    NSPredicate *predicate = [self predicate];
//    request.predicate = predicate;
//    
//    NSError *error = nil;
//    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
//    if (!results) {
//        [UIAlertView showWithError:error];
//    }
//    
//    if (results.count > 0) {
//        return results.firstObject;
//    }
//    
//    return nil;
//}
//
//- (NSPredicate *)predicate {
//    return nil;
//}

@end
