//
//  ThermostatListController.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/4/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "ThermostatListController.h"
#import "ThermostatViewController.h"
#import "ThermostatListDataSource.h"
#import "NestStructureManager.h"
#import "NestThermostatManager.h"

@interface ThermostatListController() <NestThermostatManagerDelegate>

@property (strong, nonatomic) IBOutlet ThermostatListDataSource *dataSource;
@property (strong, nonatomic) NestStructureManager *structureManager;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ThermostatListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activity startAnimating];
}

- (void)setStructure:(Structure *)structure {
    _structure = structure;
    
    self.title = structure.name;
}

- (void)setThermostatManager:(NestThermostatManager *)thermostatManager {
    _thermostatManager = thermostatManager;
    [self.thermostatManager.delegates addPointer:(__bridge void * _Nullable)(self)];
    for (Thermostat *t in self.structure.thermostats) {
        [self.thermostatManager beginSubscriptionForThermostat:t];
    }
    self.dataSource.thermostats = self.structure.thermostats;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"OpenThermostat"]) {
        ThermostatViewController *viewController = segue.destinationViewController;
        long row = [self.tableView indexPathForSelectedRow].row;
        viewController.thermostat = self.dataSource.thermostats[row];
        viewController.thermostatManager = self.thermostatManager;
    }
}


#pragma mark - NestThermostatManagerDelegate
- (void)thermostatValuesChanged:(Thermostat *)thermostat {
    [self.tableView reloadData];
    [self.activity stopAnimating];
    self.activity.hidden = YES;
}

@end
