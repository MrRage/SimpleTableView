//
//  STVCoreDataListController.h
//  SimpleTableView
//
//  Created on 11/20/10.
//  Copyright © 2010 Dustin Martin. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <CoreData/CoreData.h>

#import "STVTableViewController.h"

typedef void (^STVCoreDataCellDidSelect)(id viewController, id cell, id entity);
typedef void (^STVCoreDataCellConfig)(id cell, id entity);

@interface STVCoreDataListController : STVTableViewController <NSFetchedResultsControllerDelegate> {
@private 
    NSString *cellReuseIdentifier;
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    NSString *entityName;
    NSPredicate *predicate;
    NSArray *sortDescriptors;
    STVCellNew newCell;
    STVCoreDataCellDidSelect didSelectCell;
    STVCoreDataCellConfig configCell;      
}

@property (nonatomic, copy) NSString *cellReuseIdentifier;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, copy) NSString *entityName;
@property (nonatomic, copy) NSPredicate *predicate;
@property (nonatomic, copy) NSArray *sortDescriptors;

// Cell Configuration 
@property (nonatomic, copy) STVCellNew newCell;
@property (nonatomic, copy) STVCoreDataCellDidSelect didSelectCell;
@property (nonatomic, copy) STVCoreDataCellConfig configCell;

@end
