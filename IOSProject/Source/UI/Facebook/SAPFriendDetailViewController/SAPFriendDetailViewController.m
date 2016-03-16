//
//  SAPFriendDetailViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFriendDetailViewController.h"

#import "SAPFriendDetailView.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPFriendDetailViewController, SAPFriendDetailView, friendDetailView);

@interface SAPFriendDetailViewController ()

@end

@implementation SAPFriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
