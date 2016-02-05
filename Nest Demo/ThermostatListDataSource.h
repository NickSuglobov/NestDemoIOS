//
//  ThermostatListDataSource.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/4/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Thermostat.h"

@interface ThermostatListDataSource : NSObject <UITableViewDataSource>

@property(nonatomic, strong) NSArray<Thermostat *> *thermostats;

@end
