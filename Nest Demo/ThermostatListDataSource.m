//
//  ThermostatListDataSource.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/4/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "ThermostatListDataSource.h"
#import "Thermostat.h"

@interface ThermostatListDataSource()

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ThermostatListDataSource

- (void)setThermostats:(NSArray<Thermostat *> *)thermostats {
    _thermostats = thermostats;
    [self.tableView reloadData];
}

#pragma mark - TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView = tableView;
    return self.thermostats.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ThermostatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Thermostat *thermostat = self.thermostats[indexPath.row];
    cell.textLabel.text = thermostat.nameLong;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ldº", (long)thermostat.targetTemperatureF];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:NSLocalizedString(@"You have %d thermostats", @"You have %d thermostats"), self.thermostats.count];
}

@end
