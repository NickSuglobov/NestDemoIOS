//
//  RequestManager.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestSuccessCompletion)(NSDictionary *result, NSURLResponse *response);
typedef void (^RequestFailureCompletion)(NSURLResponse *response, NSError *error);

@interface RequestManager : NSObject

- (void)POST:(NSURL *)resource
      params:(NSDictionary *)params
     success:(RequestSuccessCompletion)success
     failure:(RequestFailureCompletion)failure;

@end
