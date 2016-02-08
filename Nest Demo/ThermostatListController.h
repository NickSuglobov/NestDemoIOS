//
//  ThermostatListController.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/4/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structure.h"

@class Structure, NestThermostatManager;

@interface ThermostatListController : UIViewController

@property (strong, nonatomic) Structure *structure;
@property (strong, nonatomic) NestThermostatManager *thermostatManager;

@end
