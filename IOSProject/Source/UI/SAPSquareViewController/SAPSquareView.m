//
//  SAPSquareView.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSquareView.h"
#import "SAPWeakifyStongifyMacro.h"

static NSTimeInterval const kSAPAnimationDuration = 1.0;

@interface SAPSquareView ()

@property (nonatomic, assign, getter=isMoving)      BOOL    moving;
@property (nonatomic, assign)                       BOOL    proceedLoop;

static inline
CGPoint CGPointBySubstractingRects(CGRect minuend, CGRect subtrahend);

- (CGRect)squareFrameWithSquarePosition:(SAPSquarePosition)squarePosition;
- (SAPSquarePosition)nextPositionWithSquarePosition:(SAPSquarePosition)squarePosition;

- (void)changeStartStopButtonColor:(UIColor *)color title:(NSString *)title;
- (void)changeButtonAppearanceForStop;
- (void)changeButtonAppearanceForStart;

- (void)loopMove;

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
            [self changeButtonAppearanceForStop];
            self.proceedLoop = YES;
            [self loopMove];
            
        } else {
            [self changeButtonAppearanceForStart];
            self.proceedLoop = NO;
        }
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

static inline
CGPoint CGPointBySubstractingRects(CGRect minuend, CGRect subtrahend) {
    return CGPointMake(CGRectGetMaxX(minuend) - CGRectGetWidth(subtrahend),
                       CGRectGetMaxY(minuend) - CGRectGetHeight(subtrahend));
}

- (CGRect)squareFrameWithSquarePosition:(SAPSquarePosition)squarePosition{
    CGRect squareFrame = self.squareLabel.frame;
    CGPoint visibleOrigin = CGPointBySubstractingRects(self.bounds, squareFrame);
    CGPoint resultOrigin = CGPointZero;
    switch (squarePosition) {
        case kSAPSquarePositionTopRight:
            resultOrigin.x = visibleOrigin.x;
            break;
            
        case kSAPSquarePositionBottomLeft:
            resultOrigin.y = visibleOrigin.y;
            break;
            
        case kSAPSquarePositionBottomRight:
            resultOrigin = visibleOrigin;
            break;
            
        default:
            break;
    }
    
    squareFrame.origin = resultOrigin;
    
    return squareFrame;
}

- (SAPSquarePosition)nextPositionWithSquarePosition:(SAPSquarePosition)squarePosition {
    NSUInteger nextPositionSummand = kSAPSquarePositionBottomLeft == squarePosition ? 2 : 1;
    
    return (squarePosition + nextPositionSummand) % kSAPSquarePositionsCount;
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

- (void)loopMove {
    SAPWeakify(self);
    [self setSquarePosition:[self nextPositionWithSquarePosition:self.squarePosition]
                   animated:YES
          completionHandler:^{
              SAPStrongify(self,);
              if (self.proceedLoop) {
                  [self loopMove];
              }
          }
     ];
}

@end
