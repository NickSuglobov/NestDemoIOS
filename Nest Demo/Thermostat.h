/**
 *  Copyright 2014 Nest Labs Inc. All Rights Reserved.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

@import Foundation;

typedef enum {
    ThermostatStateOff,
    ThermostatStateHeating,
    ThermostatStateCooling
} ThermostatState;

@interface Thermostat : NSObject

@property (nonatomic, strong) NSString *thermostatId;
@property (nonatomic, strong) NSString *nameLong;
@property (nonatomic) BOOL hasFan;
@property (nonatomic) BOOL fanTimerActive;
@property (nonatomic) NSInteger ambientTemperatureF;
@property (nonatomic) NSInteger targetTemperatureF;
@property (nonatomic) NSInteger humidity;
@property (nonatomic, strong) NSString *hvacState;
@property (nonatomic, readonly) ThermostatState state;
@property (nonatomic) BOOL hasLeaf;

@end
