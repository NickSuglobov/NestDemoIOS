//
//  WebViewController.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStartURL];
}

- (void)loadStartURL {
    if (self.startURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.startURL];
        [self.webView loadRequest:request];
    }
}

@end
