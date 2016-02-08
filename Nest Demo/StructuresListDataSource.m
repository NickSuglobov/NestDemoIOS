//
//  StructuresListDataSource.m
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/5/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "StructuresListDataSource.h"
#import "Structure.h"

@interface StructuresListDataSource()

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation StructuresListDataSource

- (void)setStructures:(NSArray<Structure *> *)structures {
    _structures = structures;
    [self.tableView reloadData];
}

#pragma mark - TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView = tableView;
    return self.structures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StructureCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Structure *structure = self.structures[indexPath.row];
    cell.textLabel.text = structure.name;
    cell.detailTextLabel.text = structure.status;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
