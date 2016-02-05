//
//  ThermostatViewController.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/4/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "ThermostatViewController.h"
#import "NestThermostatManager.h"
#import "Thermostat.h"
#import "Rotor.h"
#import "UIColor+Extensions.h"

@interface ThermostatViewController() <NestThermostatManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ambientTemperatureLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *ambientTemperatureMeter;
@property (weak, nonatomic) IBOutlet UILabel *targetTemperatureLabel;
@property (weak, nonatomic) IBOutlet UISlider *temperatureSlider;
@property (weak, nonatomic) IBOutlet UIImageView *coolerView;
@property (weak, nonatomic) IBOutlet UIImageView *leafView;
@property (strong, nonatomic) IBOutlet Rotor *rotor;
@property (weak, nonatomic) IBOutlet UIProgressView *humidityMeter;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;

@end

@implementation ThermostatViewController

static CGFloat const CurrentTemperatureMin = -4;
static CGFloat const CurrentTemperatureMax = 140;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUIWithThermostat:self.thermostat];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.coolerView.layer.anchorPoint = CGPointMake(0.44, 0.50);
}

- (void)setThermostatManager:(NestThermostatManager *)thermostatManager {
    _thermostatManager = thermostatManager;
    [_thermostatManager.delegates addPointer:(__bridge void * _Nullable)(self)];
}

- (void)setThermostat:(Thermostat *)thermostat {
    _thermostat = thermostat;
    [self updateUIWithThermostat:thermostat];
}

- (void)saveChanges {
    [self.thermostatManager saveChangesForThermostat:self.thermostat];
}

- (IBAction)updateTemperature:(UISlider *)sender {
    self.thermostat.targetTemperatureF = sender.value;
    [self saveChanges];
}

- (void)updateUIWithThermostat:(Thermostat *)thermostat {
    self.temperatureSlider.value = thermostat.targetTemperatureF;
    self.targetTemperatureLabel.text = [NSString stringWithFormat:@"%ldº", (long)thermostat.targetTemperatureF];
    self.ambientTemperatureLabel.text = [NSString stringWithFormat:@"%ldº", (long)thermostat.ambientTemperatureF];
    self.humidityLabel.text = [NSString stringWithFormat:@"%ld %%", (long)thermostat.humidity];
    self.humidityMeter.progress = thermostat.humidity / 100.0;
    self.ambientTemperatureMeter.progress = (thermostat.ambientTemperatureF - CurrentTemperatureMin) / (CurrentTemperatureMax - CurrentTemperatureMin);
    
    self.title = thermostat.nameLong;
    
    self.leafView.tintColor = thermostat.hasLeaf ? [UIColor leafColor] : [UIColor lightGrayColor];
    switch (thermostat.state) {
        case ThermostatStateOff:
            [self.rotor stopAnimating];
            self.coolerView.tintColor = [UIColor lightGrayColor];
            break;
            
        case ThermostatStateHeating:
            [self.rotor startAnimating];
            self.coolerView.tintColor = [UIColor hotColor];
            break;
            
        case ThermostatStateCooling:
            [self.rotor startAnimating];
            self.coolerView.tintColor = [UIColor coldColor];
            break;
    }
}


#pragma mark - NestThermostatManagerDelegate
- (void)thermostatValuesChanged:(Thermostat *)thermostat {
    NSLog(@"thermostat changed: %@, %ld C", thermostat, (long)thermostat.ambientTemperatureF);
    [self updateUIWithThermostat:thermostat];
}

@end
