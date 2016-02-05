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

@interface ThermostatViewController() <NestThermostatManagerDelegate>

@property (nonatomic, strong) NestThermostatManager *thermostatManager;
@property (weak, nonatomic) IBOutlet UILabel *ambientTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetTemperatureLabel;
@property (weak, nonatomic) IBOutlet UISlider *temperatureSlider;
@property (weak, nonatomic) IBOutlet UIImageView *coolerView;
@property (weak, nonatomic) IBOutlet UIImageView *leafView;

@end

@implementation ThermostatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUIWithThermostat:self.thermostat];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.coolerView.layer.anchorPoint = CGPointMake(0.44, 0.50);
    [self animate];
}

- (void)animate {
    [UIView animateWithDuration:.25 delay:0.0 options: UIViewAnimationOptionCurveLinear animations:^{
        self.coolerView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 delay:0.0 options: UIViewAnimationOptionCurveLinear animations:^{
            self.coolerView.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            [self animate];
        }];
    }];
}

- (NestThermostatManager *)thermostatManager {
    if (!_thermostatManager) {
        _thermostatManager = [NestThermostatManager new];
        [_thermostatManager.delegates addPointer:(__bridge void * _Nullable)(self)];
    }
    
    return _thermostatManager;
}

- (void)setThermostat:(Thermostat *)thermostat {
    _thermostat = thermostat;
    [self.thermostatManager beginSubscriptionForThermostat:thermostat];
    [self updateUIWithThermostat:thermostat];
}

- (IBAction)saveChanges {
    [self.thermostatManager saveChangesForThermostat:self.thermostat];
}

- (IBAction)updateTemperature:(UISlider *)sender {
    self.thermostat.targetTemperatureF = sender.value;
    [self saveChanges];
}

- (void)updateUIWithThermostat:(Thermostat *)thermostat {
    self.temperatureSlider.value = thermostat.targetTemperatureF;
    self.targetTemperatureLabel.text = [NSString stringWithFormat:@"%ld", (long)thermostat.targetTemperatureF];
    self.ambientTemperatureLabel.text = [NSString stringWithFormat:@"%ld", (long)thermostat.ambientTemperatureF];
    self.title = thermostat.nameLong;
}


#pragma mark - NestThermostatManagerDelegate
- (void)thermostatValuesChanged:(Thermostat *)thermostat {
    NSLog(@"thermostat changed: %@, %ld C", thermostat, (long)thermostat.ambientTemperatureF);
    [self updateUIWithThermostat:thermostat];
}

@end
