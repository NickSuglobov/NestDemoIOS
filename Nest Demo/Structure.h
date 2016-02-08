//
//  Structure.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/5/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Thermostat.h"

@interface Structure : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *structureId;
@property(nonatomic, strong) NSArray<Thermostat *> *thermostats;

@end
