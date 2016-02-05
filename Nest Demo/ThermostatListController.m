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

@interface ThermostatListController() <NestStructureManagerDelegate, NestThermostatManagerDelegate>

@property (strong, nonatomic) IBOutlet ThermostatListDataSource *dataSource;
@property (strong, nonatomic) NestStructureManager *structureManager;
@property (nonatomic, strong) NestThermostatManager *thermostatManager;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ThermostatListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.structureManager = [[NestStructureManager alloc] init];
    self.structureManager.delegate = self;
    [self.structureManager initialize];
    [self.activity startAnimating];
    
    self.thermostatManager = [NestThermostatManager new];
    [self.thermostatManager.delegates addPointer:(__bridge void * _Nullable)(self)];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"OpenThermostat"]) {
        ThermostatViewController *viewController = segue.destinationViewController;
        long row = [self.tableView indexPathForSelectedRow].row;
        viewController.thermostat = self.dataSource.thermostats[row];
        [self.thermostatManager.delegates addPointer:(__bridge void * _Nullable)(viewController)];
    }
}


#pragma mark - NestStructureManagerDelegate
- (void)nestStructureManagerDelegate:(NestStructureManager *)manager didLoadThermostats:(NSArray<Thermostat *> *)thermostats name:(NSString *)name {
    self.title = name;
    self.dataSource.thermostats = thermostats;
    self.activity.hidden = YES;
    [self.activity stopAnimating];
    
    
    for (Thermostat *t in thermostats) {
        [self.thermostatManager beginSubscriptionForThermostat:t];
    }
}

#pragma mark - NestThermostatManagerDelegate
- (void)thermostatValuesChanged:(Thermostat *)thermostat {
    [self.tableView reloadData];
}

@end
