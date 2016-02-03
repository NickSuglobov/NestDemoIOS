//
//  AuthWebViewDelegate.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "AuthWebViewDelegate.h"
#import "AppConfiguration.h"

@implementation AuthWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"Loading URL: %@", request.URL);
    
    NSURL *redirectURL = [AppConfiguration sharedInstance].redirectURL;
    __weak typeof(self) weakSelf = self;
    if ([[request.URL host] isEqualToString:[redirectURL host]]) {
        NSLog(@"Successfully logged in: %@", request.URL);
        if (weakSelf.onLogin) {
            weakSelf.onLogin(request.URL);
        }
    }
    
    return YES;
}

@end
