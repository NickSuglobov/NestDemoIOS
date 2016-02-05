//
//  AuthWebViewDelegate.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "AuthWebViewDelegate.h"
#import "AppConfiguration.h"

@interface AuthWebViewDelegate()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation AuthWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.activity.hidden = NO;
    [self.activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activity stopAnimating];
    self.activity.hidden = YES;
}

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
