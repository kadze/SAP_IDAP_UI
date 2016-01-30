//
//  SAPSquareView.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSquareView.h"

static NSTimeInterval kSAPAnimationDuration = 1.0;

@implementation SAPSquareView

#pragma mark -
#pragma mark Accessors

- (void)setSquarePosition:(SAPSquarePosition)SquarePosition {
    [self setSquarePosition:SquarePosition animated:NO];
}

#pragma mark -
#pragma mark Public

- (void)moveSquare {
    SAPSquarePosition newPosition = kSAPTopLeft;
    
    switch (self.SquarePosition) {
        case kSAPTopLeft:
            newPosition = kSAPTopRight;
            
            break;
            
        case kSAPTopRight:
            newPosition = kSAPBottomRight;
            
            break;
        case kSAPBottomRight:
            newPosition = kSAPBottomLeft;
            
            break;
            
        default:
            newPosition = kSAPTopLeft;
            
            break;
    }
    
    [self setSquarePosition:newPosition animated:YES];
}

- (void)setSquarePosition:(SAPSquarePosition)SquarePosition animated:(BOOL)animated {
    [self setSquarePosition:SquarePosition animated:animated completionHandler:nil];
}

- (void)setSquarePosition:(SAPSquarePosition)SquarePosition
                 animated:(BOOL)animated
        completionHandler:(void(^)(bool))handler
{
   void (^animations)(void) = ^{
        CGRect squareFrame = self.square.frame;
        CGRect selfFrame = self.frame;
        CGFloat rightOriginX = CGRectGetWidth(selfFrame) - CGRectGetWidth(squareFrame);
        CGFloat bottomOriginY = CGRectGetHeight(selfFrame) - CGRectGetHeight(squareFrame);
        switch (SquarePosition) {
            case kSAPTopLeft:
                squareFrame.origin.x = 0;
                squareFrame.origin.y = 0;
                
                break;
                
            case kSAPTopRight:
                squareFrame.origin.x = rightOriginX;
                squareFrame.origin.y = 0;
                
                break;
                
            case kSAPBottomLeft:
                squareFrame.origin.x = 0;
                squareFrame.origin.y = bottomOriginY;
                
                break;
                
            case kSAPBottomRight:
                squareFrame.origin.x = rightOriginX;
                squareFrame.origin.y = bottomOriginY;
                
                break;
                
            default:
                break;
        }
        
        self.square.frame = squareFrame;
        
        _SquarePosition = SquarePosition;
    };
    
    if (animated) {
        [UIView animateWithDuration:kSAPAnimationDuration
                         animations:animations
                         completion:handler];
    } else {
        animations();
    }
    
    
    
}
@end
