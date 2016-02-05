//
//  ThermostatViewController.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/4/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Thermostat, NestThermostatManager;

@interface ThermostatViewController : UIViewController

@property (strong, nonatomic) Thermostat *thermostat;
@property (strong, nonatomic) NestThermostatManager *thermostatManager;

@end
