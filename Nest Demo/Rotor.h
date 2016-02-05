//
//  Rotor.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/5/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Rotor : NSObject

@property (nonatomic, weak) IBOutlet UIView *targetView;

- (void)startAnimating;
- (void)stopAnimating;

@end
