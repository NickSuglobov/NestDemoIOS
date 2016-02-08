//
//  StructuresViewController.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/5/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "StructuresViewController.h"
#import "NestStructureManager.h"
#import "StructuresListDataSource.h"
#import "ThermostatListController.h"
#import "NestThermostatManager.h"

@interface StructuresViewController() <NestStructureManagerDelegate>

@property (strong, nonatomic) NestStructureManager *structureManager;
@property (strong, nonatomic) NestThermostatManager *thermostatManager;

@property (strong, nonatomic) IBOutlet StructuresListDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StructuresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.structureManager = [[NestStructureManager alloc] init];
    self.structureManager.delegate = self;
    [self.structureManager initialize];
    
    self.thermostatManager = [[NestThermostatManager alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"OpenStructure"]) {
        ThermostatListController *viewController = segue.destinationViewController;
        long row = [self.tableView indexPathForSelectedRow].row;
        viewController.structure = self.dataSource.structures[row];
        viewController.thermostatManager = self.thermostatManager;
    }
}

#pragma mark - NestStructureManagerDelegate
- (void)nestStructureManagerDelegate:(NestStructureManager *)manager didLoadStructures:(NSArray *)structures {
    self.dataSource.structures = structures;
    self.activity.hidden = YES;
    [self.activity stopAnimating];
}

@end
