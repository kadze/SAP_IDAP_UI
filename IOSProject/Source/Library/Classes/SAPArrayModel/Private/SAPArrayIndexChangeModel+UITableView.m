//
//  SAPArrayIndexChangeModel+UITableView.m
//  IOSProject
//
//  Created by S A P on 2/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayIndexChangeModel+UITableView.h"
#import "NSIndexPath+SAPExtensions.h"

#import <UIKit/UIKit.h>

@implementation SAPArrayIndexChangeModel (UITableView)

@dynamic indexPath;

- (NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:self.index];
}

- (void)updateTableView:(UITableView *)tableView {
    NSIndexPath *indexPath = self.indexPath;
    
    switch (self.changeType) {
        case kSAPChangeTypeObjectRemoved:
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
        case kSAPChangeTypeObjectAdded:
            [tableView insertRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationTop];
            [tableView scrollToRowAtIndexPath:self.indexPath
                             atScrollPosition:UITableViewScrollPositionNone animated:YES];
            
            break;
            
        default:
            
            break;
    }
}

@end
