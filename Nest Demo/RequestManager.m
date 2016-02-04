//
//  RequestManager.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "RequestManager.h"

@interface RequestManager()
@property (nonatomic, strong) NSURLSession *urlSession;
@end

@implementation RequestManager


- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:configuration
                                                        delegate:nil
                                                   delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

- (void)POST:(NSURL *)resource
      params:(NSDictionary *)params
     success:(RequestSuccessCompletion)success
     failure:(RequestFailureCompletion)failure {
    
    NSURLRequest *request = [self POSTRequestWithURL:resource params:params];
    NSLog(@"POST: %@", request.URL);
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if (nil != error) {
                                                            if (failure) {
                                                                failure(response, error);
                                                            }
                                                            return;
                                                        }
                                                        
                                                        NSError *jsonError;
                                                        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                                        if (nil != jsonError) {
                                                            if (failure) {
                                                                failure(response, jsonError);
                                                            }
                                                            return;
                                                        }
                                                        
                                                        if (success) {
                                                            success(json, response);
                                                        }                 
                                                    }];
    
    [task resume];
}


- (NSURLRequest *)POSTRequestWithURL:(NSURL *)url params:(NSDictionary *)params {
    NSURL *urlWithParams = [self urlFromResource:url params:params];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlWithParams];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"form-data" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

- (NSArray *)queryItemsFromDictionary:(NSDictionary *)params {
    NSMutableArray *queryItems = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSObject *value, BOOL *stop) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:[value description]]];
    }];
    return [queryItems copy];
}

- (NSURL *)urlFromResource:(NSURL *)resource params:(NSDictionary *)params {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:[resource absoluteString]];
    urlComponents.queryItems = [self queryItemsFromDictionary:params];
    return urlComponents.URL;
}

@end
