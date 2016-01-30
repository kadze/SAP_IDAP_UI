//
//  SAPSquareView.h
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, SAPSquarePosition) {
    kSAPTopLeft = 1,
    kSAPTopRight,
    kSAPBottomLeft,
    kSAPBottomRight
};


@interface SAPSquareView : UIView
@property (nonatomic, assign) SAPSquarePosition SquarePosition;
@property (nonatomic, strong) IBOutlet UILabel  *square;
@property (nonatomic, strong) IBOutlet UIButton *moveButton;

- (void)moveSquare;

- (void)setSquarePosition:(SAPSquarePosition)SquarePosition
                 animated:(BOOL)animated;

- (void)setSquarePosition:(SAPSquarePosition)SquarePosition
                 animated:(BOOL)animated
        completionHandler:(void(^)(bool))handler;

@end
