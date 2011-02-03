//
//  STVTableViewDataSource.h
//  SimpleTableView
//
//  Created on 11/19/10.
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

#import <UIKit/UIKit.h>

#import "STVCellController.h"

@class STVSection;
@class STVCellController;

@interface STVTableViewDataSource : NSObject 
<UITableViewDataSource, UITableViewDelegate> {
@private
    id viewController;
    NSUndoManager *undoManager;
    NSMutableArray *sections;
    BOOL removeSectionsIfEmpty;
}

// Delegate
// ----------------------------
@property (nonatomic, assign) id viewController;

// Core Data Source, Sections Array
// ----------------------------
@property (nonatomic, retain) NSUndoManager *undoManager;

// Core Data Source, Sections Array
// ----------------------------
@property (nonatomic, retain) NSMutableArray *sections;

// Editing Options for Sections
// ----------------------------
@property (nonatomic, assign) BOOL removeSectionsIfEmpty;

// Standard Initilization
// ----------------------------
- (id)initWithViewController:(id)viewController;

// Table Navigation Methods
// ----------------------------
- (id<STVCellControllerProtocol>)cellControllerForIndexPath:(NSIndexPath *)indexPath;
- (STVSection *)sectionForIndexPath:(NSInteger)sectionIndex;

// Section Managment 
// ----------------------------
- (void)removeSection:(STVSection *)section;
- (void)addSection:(STVSection *)section;

- (void)clearSections;

@end