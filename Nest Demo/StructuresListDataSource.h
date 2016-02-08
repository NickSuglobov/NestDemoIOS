//
//  StructuresListDataSource.h
//  Nest Demo
//
//  Created by Nikolay Suglobov on 2/5/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Structure;

@interface StructuresListDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray<Structure *> *structures;

@end
