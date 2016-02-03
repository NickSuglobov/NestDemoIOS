//
//  AppConfiguration.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "AppConfiguration.h"
#import "AppConstants.h"

static AppConfiguration *_instance;

@implementation AppConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        _authURL = [self authorizationURL];
        _redirectURL = [NSURL URLWithString:kRedirectURL];
    }
    return self;
}

+ (AppConfiguration *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [self new];
    });
    return _instance;
}

- (NSURL *)authorizationURL {
    NSString *authorizationPath = [NSString stringWithFormat:@"https://%@/login/oauth2?client_id=%@&state=%@", kNestCurrentAPIDomain, kNestClientID, kNestState];
    return [NSURL URLWithString:authorizationPath];
}

@end
