//
//  SAPDBImage+CoreDataProperties.h
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SAPDBImage.h"

@interface SAPDBImage (CoreDataProperties)
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSSet    *users;

@end

@interface SAPDBImage (CoreDataGeneratedAccessors)

- (void)addUser:(SAPUser *)value;
- (void)removeUser:(SAPUser *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
