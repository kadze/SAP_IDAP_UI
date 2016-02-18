//
//  SAPArrayDoubleIndexChangeModel+UITableView.m
//  IOSProject
//
//  Created by S A P on 2/18/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayDoubleIndexChangeModel+UITableView.h"

#import "UITableView+SAPExtensions.h"

@implementation SAPArrayDoubleIndexChangeModel (UITableView)
- (void)updateTableView:(UITableView *)tableView {
//    NSIndexPath *indexPath = self.indexPath;
//    NSArray *indexPaths = @[indexPath];
    SAPArrayIndexChangeType changeType = self.changeType;
    
    [tableView updateWithBlock:^(UITableView *tableView) {
        switch (changeType) {
            case kSAPChangeTypeObjectExchanged:
                //
                break;
                
            case kSAPChangeTypeObjectMoved:
                //
                break;
                
            default:
                break;
        }
    }];
}
@end
