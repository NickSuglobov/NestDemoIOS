//
//  UIView+Extensions.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/5/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (Extensions)

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

@end
