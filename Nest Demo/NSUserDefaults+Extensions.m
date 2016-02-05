//
//  NSUserDefaults+Extensions.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "NSUserDefaults+Extensions.h"

@implementation NSUserDefaults (Extensions)

static NSString *const kAuthorizationTokenKey = @"AuthorizationToken";
static NSString *const kAccessTokenKey = @"AccessToken";
static NSString *const kAccessTokenExpirationKey = @"AccessTokenExpiration";

- (void)setAuthorizationToken:(NSString *)authorizationToken {
    [self setValue:authorizationToken forKey:kAuthorizationTokenKey];
    [self synchronize];
}

- (NSString *)authorizationToken {
    return [self stringForKey:kAuthorizationTokenKey];
}

- (void)setAccessToken:(NSString *)accessToken {
    [self setValue:accessToken forKey:kAccessTokenKey];
    [self synchronize];
}

- (NSString *)accessToken {
    return [self stringForKey:kAccessTokenKey];
}


- (NSTimeInterval)accessTokenExpiration {
    return [self doubleForKey:kAccessTokenExpirationKey];
}

- (void)setAccessTokenExpiration:(NSTimeInterval)accessTokenExpiration {
    [self setDouble:accessTokenExpiration forKey:kAccessTokenExpirationKey];
    [self synchronize];
}

@end
