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
        _redirectURL = [NSURL URLWithString:kRedirectURL];
        _apiDomain = kNestCurrentAPIDomain;
        _clientId = kNestClientID;
        _clientSecret = kNestClientSecret;
        _state = kNestState;
        _authURL = [self authorizationURL];
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
    NSString *authorizationPath = [NSString stringWithFormat:@"https://%@/login/oauth2?client_id=%@&state=%@", _apiDomain, _clientId, _state];
    return [NSURL URLWithString:authorizationPath];
}

@end
