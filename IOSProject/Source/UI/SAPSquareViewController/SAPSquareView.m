//
//  SAPSquareView.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSquareView.h"

static NSTimeInterval kSAPAnimationDuration = 1.0;

@interface SAPSquareView ()

- (CGRect)squareFrameWithSquarePosition:(SAPSquarePosition)squarePosition;
- (SAPSquarePosition)nextPositionWithSquarePosition:(SAPSquarePosition)squarePosition;

@end

@implementation SAPSquareView

#pragma mark -
#pragma mark Accessors

- (void)setSquarePosition:(SAPSquarePosition)squarePosition {
    [self setSquarePosition:squarePosition animated:NO];
}

#pragma mark -
#pragma mark Public

- (void)moveSquare {
    [self setSquarePosition:[self nextPositionWithSquarePosition:self.squarePosition]
                   animated:YES];
}

- (void)setSquarePosition:(SAPSquarePosition)squarePosition animated:(BOOL)animated {
    [self setSquarePosition:squarePosition animated:animated completionHandler:nil];
}

- (void)setSquarePosition:(SAPSquarePosition)squarePosition
                 animated:(BOOL)animated
        completionHandler:(SAPVoidBlock)handler
{
    [UIView animateKeyframesWithDuration:animated ? kSAPAnimationDuration : 0.0
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations: ^{
                                  self.squareLabel.frame = [self squareFrameWithSquarePosition:squarePosition];
                              }
                              completion:^(BOOL finished) {
                                  if (finished) {
                                      _squarePosition = squarePosition;
                                  }
                                  
                                  if (handler) {
                                      handler();
                                  }
                              }];
}

- (void)changeButtonAppearanceForStop {
    UIButton *startStopButton = self.startStopButton;
    [startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    startStopButton.backgroundColor = [UIColor redColor];
}

- (void)changeButtonAppearanceForStart {
    UIButton *startStopButton = self.startStopButton;
    [startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    startStopButton.backgroundColor = [UIColor greenColor];
}

#pragma mark -
#pragma mark Private

- (CGRect)squareFrameWithSquarePosition:(SAPSquarePosition)squarePosition{
    CGRect selfFrame = self.frame;
    CGRect squareFrame = self.squareLabel.frame;
    CGFloat rightOriginX = CGRectGetWidth(selfFrame) - CGRectGetWidth(squareFrame);
    CGFloat bottomOriginY = CGRectGetHeight(selfFrame) - CGRectGetHeight(squareFrame);
    CGPoint resultOrigin = CGPointZero;
    switch (squarePosition) {
        case kSAPSquarePositionTopRight:
            resultOrigin.x = rightOriginX;
            break;
            
        case kSAPSquarePositionBottomLeft:
            resultOrigin.y = bottomOriginY;
            break;
            
        case kSAPSquarePositionBottomRight:
            resultOrigin.x = rightOriginX;
            resultOrigin.y = bottomOriginY;
            break;
            
        default:
            break;
    }
    
    squareFrame.origin = resultOrigin;
    
    return squareFrame;
}

- (SAPSquarePosition)nextPositionWithSquarePosition:(SAPSquarePosition)squarePosition {
    switch (squarePosition) {
        case kSAPSquarePositionTopLeft:
            return kSAPSquarePositionTopRight;
            
        case kSAPSquarePositionTopRight:
            return kSAPSquarePositionBottomRight;
            
        case kSAPSquarePositionBottomRight:
            return kSAPSquarePositionBottomLeft;
            
        default:
            return kSAPSquarePositionTopLeft;
            
    }
}

@end
