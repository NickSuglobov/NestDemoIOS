//
//  LoginViewController.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "LoginViewController.h"
#import "AppConfiguration.h"
#import "AuthWebViewDelegate.h"
#import "LoginInteractor.h"

@interface LoginViewController()

@property (strong, nonatomic) IBOutlet AuthWebViewDelegate *authWebViewDelegate;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startURL = [AppConfiguration sharedInstance].authURL;
    [self loadStartURL];
    
    __weak typeof(self) weakSelf = self;
    self.authWebViewDelegate.onLogin = ^(NSURL *redirectURL) {
        LoginInteractor *interactor = [LoginInteractor new];
        [interactor handleLoginWithRedirectURL:redirectURL viewController:weakSelf];
    };
}

@end
