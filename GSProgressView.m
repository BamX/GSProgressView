//
//  GSProgressView.m
//
//  Created by Simon Whitaker on 14/11/2012.
//  Copyright (c) 2012 Goo Software Ltd. All rights reserved.
//

#import "GSProgressView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GSProgressView

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    self.doneIconHidden = NO;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    if (progress > 1.0) progress = 1.0;
    
    if (progress != _progress) {
        _progress = progress;
        [self setNeedsDisplay];
    }
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.progress = progress;
                         }
                         completion:nil];
    }
    else {
        self.progress = progress;
    }
}

- (void)setFailure:(BOOL)failure
{
    if (_failure != failure) {
        _failure = failure;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    if ([self color] == nil)
        [self setColor:[UIColor blackColor]];
    
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = MIN(rect.size.width, rect.size.height)/2;
    
    // Start a path
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // Move to centre and draw an arc.
    
    [path moveToPoint:center];
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0 - M_PI_2 // zero degrees is east, not north, so subtract pi/2
                  endAngle:2 * M_PI * [self progress] - M_PI_2 // ditto
                 clockwise:YES];
    [path closePath];

    if (self.failure) {
        UIBezierPath *tickPath = [UIBezierPath bezierPath];
        CGFloat tickWidth = radius/3;
        [tickPath moveToPoint:CGPointMake(tickWidth, 0)];
        [tickPath addLineToPoint:CGPointMake(tickWidth, tickWidth)];
        [tickPath addLineToPoint:CGPointMake(0, tickWidth)];
        [tickPath addLineToPoint:CGPointMake(0, tickWidth * 2)];
        [tickPath addLineToPoint:CGPointMake(tickWidth, tickWidth * 2)];
        [tickPath addLineToPoint:CGPointMake(tickWidth, tickWidth * 3)];
        [tickPath addLineToPoint:CGPointMake(tickWidth * 2, tickWidth * 3)];
        [tickPath addLineToPoint:CGPointMake(tickWidth * 2, tickWidth * 2)];
        [tickPath addLineToPoint:CGPointMake(tickWidth * 3, tickWidth * 2)];
        [tickPath addLineToPoint:CGPointMake(tickWidth * 3, tickWidth * 1)];
        [tickPath addLineToPoint:CGPointMake(tickWidth * 2, tickWidth * 1)];
        [tickPath addLineToPoint:CGPointMake(tickWidth * 2, 0)];
        [tickPath closePath];

        [tickPath applyTransform:CGAffineTransformMakeRotation(-M_PI_4)];

        [tickPath applyTransform:CGAffineTransformMakeTranslation(radius * 0.3f, radius)];

        CGFloat xOffset = rect.size.width/2 - radius;
        CGFloat yOffset = rect.size.height/2 - radius;
        [tickPath applyTransform:CGAffineTransformMakeTranslation(xOffset, yOffset)];

        if (self.tickColor) {
            [[self tickColor] setFill];
            [tickPath fill];
        }

        [path appendPath:tickPath];
    }
    // If progress is 1.0, show a tick mark in the centre of the circle
    else if ([self progress] == 1.0 && self.doneIconHidden == NO) {
        /* 
         First draw a tick that looks like this:
         
           A---F
           |   |
           |   E-------D
           |           |
           B-----------C
         
         (Remember: (0,0) is top left)
         */
        UIBezierPath *tickPath = [UIBezierPath bezierPath];
        CGFloat tickWidth = radius/3;
        [tickPath moveToPoint:CGPointMake(0, 0)];                            // A
        [tickPath addLineToPoint:CGPointMake(0, tickWidth * 2)];             // B
        [tickPath addLineToPoint:CGPointMake(tickWidth * 3, tickWidth * 2)]; // C
        [tickPath addLineToPoint:CGPointMake(tickWidth * 3, tickWidth)];     // D
        [tickPath addLineToPoint:CGPointMake(tickWidth, tickWidth)];         // E
        [tickPath addLineToPoint:CGPointMake(tickWidth, 0)];                 // F
        [tickPath closePath];
        
        // Now rotate it through -45 degrees...
        [tickPath applyTransform:CGAffineTransformMakeRotation(-M_PI_4)];
        
        // ...and move it into the right place.
        [tickPath applyTransform:CGAffineTransformMakeTranslation(radius * 0.43, radius)];
        
        // Account for non-square views
        CGFloat xOffset = rect.size.width/2 - radius;
        CGFloat yOffset = rect.size.height/2 - radius;
        [tickPath applyTransform:CGAffineTransformMakeTranslation(xOffset, yOffset)];

        // Add fill color if it's set
        if (self.tickColor) {
            [[self tickColor] setFill];
            [tickPath fill];
        }

        // Add the tick path to the existing circle path
        [path appendPath:tickPath];
    };
    path.usesEvenOddFillRule = YES;
    
    [[self color] setFill];
    [path fill];
}

#pragma mark - Accessibility

- (BOOL)isAccessibilityElement {
    return YES;
}

- (NSString *)accessibilityLabel {
    return NSLocalizedString(@"Progress", @"Accessibility label for GSProgressView");
}

- (NSString *)accessibilityValue {
    // Report progress as a percentage, same as UISlider, UIProgressView
    return [NSString stringWithFormat:@"%d%%", (int)round([self progress] * 100.0)];
}

- (UIAccessibilityTraits)accessibilityTraits {
    return UIAccessibilityTraitUpdatesFrequently;
}

@end
