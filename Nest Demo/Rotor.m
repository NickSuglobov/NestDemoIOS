//
//  Rotor.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/5/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "Rotor.h"

@implementation Rotor {
    BOOL _shouldAnimate;
}

- (void)startAnimating {
    if (_shouldAnimate) {
        return;
    }
    
    _shouldAnimate = YES;
    [self animate];
}

- (void)stopAnimating {
    _shouldAnimate = NO;
}

- (void)animate {
    [UIView animateWithDuration:.25 delay:0.0 options: UIViewAnimationOptionCurveLinear animations:^{
        self.targetView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 delay:0.0 options: UIViewAnimationOptionCurveLinear animations:^{
            self.targetView.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            if (_shouldAnimate) {
                [self animate];
            }
        }];
    }];
}

@end
