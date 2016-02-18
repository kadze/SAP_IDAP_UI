//
//  SAPArrayIndexChangeModel+UITableView.m
//  IOSProject
//
//  Created by S A P on 2/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayIndexChangeModel+UITableView.h"

#import <UIKit/UIKit.h>

#import "NSIndexPath+SAPExtensions.h"
#import "UITableView+SAPExtensions.h"

@implementation SAPArrayIndexChangeModel (UITableView)

@dynamic indexPath;

- (NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:self.index];
}

- (void)updateTableView:(UITableView *)tableView {
    NSIndexPath *indexPath = self.indexPath;
    NSArray *indexPaths = @[indexPath];
    SAPArrayIndexChangeType changeType = self.changeType;
    
    [tableView updateWithBlock:^(UITableView *tableView) {
        switch (changeType) {
            case kSAPChangeTypeObjectAdded:
                [tableView insertRowsAtIndexPaths:indexPaths
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                [tableView scrollToRowAtIndexPath:indexPath
                                 atScrollPosition:UITableViewScrollPositionNone animated:YES];
                break;
                
            case kSAPChangeTypeObjectInserted:
                [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                break;
                
            case kSAPChangeTypeObjectReplaced:
                //
                break;
                
            case kSAPChangeTypeObjectRemoved:
                [tableView deleteRowsAtIndexPaths:indexPaths
                                 withRowAnimation:UITableViewRowAnimationFade];
                break;
                
            default:
                break;
        }
    }];
}

@end
