//
//  SAPSquareView.h
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAPSquareView : UIView
@property (nonatomic, strong) IBOutlet UILabel *square;
@property (nonatomic, strong) IBOutlet UIButton *moveButton;

- (void)moveSquare;

@end
