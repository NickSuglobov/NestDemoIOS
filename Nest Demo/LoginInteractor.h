//
//  LoginInteractor.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/3/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LoginInteractor : NSObject

- (void)handleLoginWithRedirectURL:(NSURL *)url viewController:(UIViewController *)viewController;

@end
