//
//  LoginInteractor.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "LoginInteractor.h"
#import "NSUserDefaults+Extensions.h"
#import "RequestManager.h"
#import "AppConfiguration.h"
#import "AppDelegate.h"

@implementation LoginInteractor

- (void)handleLoginWithRedirectURL:(NSURL *)url viewController:(UIViewController *)viewController {
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name == 'code'"];
    NSURLQueryItem *queryItem = [[urlComponents.queryItems filteredArrayUsingPredicate:predicate] firstObject];
    NSString *authCode = queryItem.value;
    [NSUserDefaults standardUserDefaults].authorizationToken = authCode;
    
    [self loadAccessTokenForAuthorizationCode:authCode success:^{
        UIViewController *vc = [viewController.storyboard instantiateViewControllerWithIdentifier:@"ThermostatScreen"];
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController = vc;
    } failure:^{
        // show error
    }];
}

- (void)loadAccessTokenForAuthorizationCode:(NSString *)authCode
                                    success:(void (^)())success
                                    failure:(void (^)())failure {
    RequestManager *manager = [RequestManager new];
    NSDictionary *params = [self accessTokenParamsWithAuthorizationCode:authCode];
    [manager POST:[self accessTokenURL]
           params:params
          success:^(NSDictionary *result, NSURLResponse *response) {
              NSLog(@"Loaded access token: %@", result);
              NSString *token = result[@"access_token"];
              NSNumber *expiration = result[@"expires_in"];
              [NSUserDefaults standardUserDefaults].accessToken = token;
              [NSUserDefaults standardUserDefaults].accessTokenExpiration = [[[NSDate date] dateByAddingTimeInterval:expiration.doubleValue] timeIntervalSince1970];
              success();
              
           } failure:^(NSURLResponse *response, NSError *error) {
               NSLog(@"Failed to load access token: %@", error);
               failure();
           }];
}

- (NSDictionary *)accessTokenParamsWithAuthorizationCode:(NSString *)authorizationCode {
    if (authorizationCode == nil) {
        NSLog(@"Error: no authorization code");
        return nil;
    }
    
    AppConfiguration *configuration = [AppConfiguration sharedInstance];
    return @{
             @"code" : authorizationCode,
             @"client_id" : configuration.clientId,
             @"client_secret" : configuration.clientSecret,
             @"grant_type" : @"authorization_code"
             };
}

- (NSURL *)accessTokenURL {
    NSString *accessPath = [NSString stringWithFormat:@"https://api.%@/oauth2/access_token", [AppConfiguration sharedInstance].apiDomain];
    NSURL *accessURL = [NSURL URLWithString:accessPath];
    return accessURL;
}

@end
