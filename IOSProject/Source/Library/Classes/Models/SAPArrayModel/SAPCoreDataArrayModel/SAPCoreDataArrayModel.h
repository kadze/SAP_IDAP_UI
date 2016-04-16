//
//  SAPCoreDataArrayModel.h
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayModel.h"

@class NSFetchedResultsController;

@interface SAPCoreDataArrayModel : SAPArrayModel
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
