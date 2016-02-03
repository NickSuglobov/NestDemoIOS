//
//  LoginInteractor.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "LoginInteractor.h"
#import "NSUserDefaults+Extensions.h"

@implementation LoginInteractor

- (void)handleLoginWithRedirectURL:(NSURL *)url viewController:(UIViewController *)viewController {
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name == 'code'"];
    NSURLQueryItem *queryItem = [[urlComponents.queryItems filteredArrayUsingPredicate:predicate] firstObject];
    NSString *token = queryItem.value;
    [NSUserDefaults standardUserDefaults].authorizationToken = token;
}

@end
