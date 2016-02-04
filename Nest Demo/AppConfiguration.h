//
//  AppConfiguration.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfiguration : NSObject

@property (readonly, strong, nonatomic) NSURL *authURL;
@property (readonly, strong, nonatomic) NSURL *redirectURL;

@property (readonly, strong, nonatomic) NSString *clientId;
@property (readonly, strong, nonatomic) NSString *clientSecret;
@property (readonly, strong, nonatomic) NSString *apiDomain;
@property (readonly, strong, nonatomic) NSString *state;

+ (AppConfiguration *)sharedInstance;

@end
