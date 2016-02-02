//
//  SAPSquareView.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSquareView.h"

static NSTimeInterval const kSAPTimerInterval     = 0.3;
static NSTimeInterval const kSAPAnimationDuration = 1.0;

@interface SAPSquareView ()
@property (nonatomic, strong) NSTimer *timer;

- (CGRect)squareFrameWithSquarePosition:(SAPSquarePosition)squarePosition;
- (SAPSquarePosition)nextPositionWithSquarePosition:(SAPSquarePosition)squarePosition;

- (void)changeStartStopButtonColor:(UIColor *)color title:(NSString *)title;
- (void)changeButtonAppearanceForStop;
- (void)changeButtonAppearanceForStart;

@end

@implementation SAPSquareView

#pragma mark -
#pragma mark Accessors

- (void)setSquarePosition:(SAPSquarePosition)squarePosition {
    [self setSquarePosition:squarePosition animated:NO];
}

- (void)setMoving:(BOOL)moving {
    if (_moving != moving) {
        _moving = moving;
        if (moving) {
            [self changeButtonAppearanceForStart];
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:kSAPTimerInterval
                                                          target:self
                                                        selector:@selector(moveSquare)
                                                        userInfo:nil
                                                         repeats:YES];
        } else {
            [self changeButtonAppearanceForStop];
            
            self.timer = nil;
        }
    }
}

- (void)setTimer:(NSTimer *)timer {
    if (_timer != timer) {
        [_timer invalidate];
        _timer = timer;
    }
}

#pragma mark -
#pragma mark Public

- (void)moveSquare {
    [self setSquarePosition:[self nextPositionWithSquarePosition:self.squarePosition]
                   animated:YES];
}

- (void)startStopMoving {
    self.moving = !(self.isMoving);
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

- (void)changeStartStopButtonColor:(UIColor *)color title:(NSString *)title {
    UIButton *startStopButton = self.startStopButton;
    startStopButton.backgroundColor = color;
    [startStopButton setTitle:title forState:UIControlStateNormal];
}

- (void)changeButtonAppearanceForStop {
    [self changeStartStopButtonColor:[UIColor redColor] title:@"Stop"];
}

- (void)changeButtonAppearanceForStart {
    [self changeStartStopButtonColor:[UIColor greenColor] title:@"Start"];
}

@end
