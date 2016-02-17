//
//  SAPArrayIndexChangeModel+UITableView.m
//  IOSProject
//
//  Created by S A P on 2/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayIndexChangeModel+UITableView.h"

#import <UIKit/UIKit.h>

@implementation SAPArrayIndexChangeModel (UITableView)

- (void)updateTableView:(UITableView *)tableView {
    switch (self.changeType) {
        case kSAPChangeTypeObjectRemoved:
            [tableView deleteRowsAtIndexPaths:[self indexPathsForIndex:index1]
                             withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
        case kSAPChangeTypeObjectAdded:
            [tableView insertRowsAtIndexPaths:[self indexPathsForIndex:index1]
                             withRowAnimation:UITableViewRowAnimationTop];
            [tableView scrollToRowAtIndexPath:[self indexPathForIndex:index1]
                             atScrollPosition:UITableViewScrollPositionNone animated:YES];
            
            break;
            
        default:
            
            break;
    }
}

@end
