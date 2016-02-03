//
//  AuthWebViewDelegate.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthWebViewDelegate : NSObject <UIWebViewDelegate>

typedef void(^LoggedInBlock)(NSURL *redirectURL);

@property (nonatomic, copy) LoggedInBlock onLogin;

@end
