//
//  TintImageView.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/5/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "TintImageView.h"

@implementation TintImageView

- (void)setImage:(UIImage *)image {
    if (self.useTintColor) {
        [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    }
    else {
        [super setImage:image];
    }
}

- (void)setUseTintColor:(BOOL)useTintColor {
    _useTintColor = useTintColor;
    UIImageRenderingMode mode = useTintColor ? UIImageRenderingModeAlwaysTemplate : UIImageRenderingModeAlwaysOriginal;
    self.image = [self.image imageWithRenderingMode:mode];
}

@end
