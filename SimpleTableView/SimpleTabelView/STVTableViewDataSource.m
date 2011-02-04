//
//  STVTableViewDataSource.m
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

#import "STVTableViewDataSource.h"

#import "STVSection.h"
#import "STVCellController.h"
#import "STVGradientBackgroundView.h"

@implementation STVTableViewDataSource

@synthesize viewController, undoManager, sections, removeSectionsIfEmpty;

#pragma mark -
#pragma mark Initialization

- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithViewController:(id)aViewController {
    if ((self = [super init])) {
        sections = [[NSMutableArray arrayWithCapacity:1] retain];
        viewController = aViewController;
    }
    return self;
}

#pragma mark -
#pragma mark Data Model manipulation

- (void)clearSections {
    [sections removeAllObjects];
}

- (void)removeSection:(STVSection *)section {
    [sections removeObject:section];
}

- (void)addSection:(STVSection *)section {
    [sections addObject:section];
}

#pragma mark -
#pragma mark Table Navigation

- (STVSection *)sectionForIndexPath:(NSInteger)sectionIndex {
    return [sections objectAtIndex:sectionIndex];
}

- (id<STVCellControllerProtocol>)cellControllerForIndexPath:(NSIndexPath *)indexPath {
    STVSection *section = [sections objectAtIndex:indexPath.section];
    return [section.cells objectAtIndex:indexPath.row];
} 

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([sections count] == 0) {
        return 1;
    }
    else {
        return [sections count];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete Contact here
        id<STVCellControllerProtocol> cell = [self cellControllerForIndexPath:indexPath];
        STVSection *section = [self sectionForIndexPath:indexPath.section];
        
        [cell deleteCell];
        [section.cells removeObject:cell];
        if (removeSectionsIfEmpty && [section.cells count] == 0) {
            [sections removeObject:section];
        }
        [tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([sections count] == 0) {
        return 0;
    }
    else {
        STVSection* sectionObject = [sections objectAtIndex:section];
        return [sectionObject.cells count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Escape if we have no sections
    if ([sections count] == 0) {
        return nil;
    }
    // Get Section Object
    STVSection* tableSection = [sections objectAtIndex:section];
    return tableSection.title;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<STVCellControllerProtocol> item = [self cellControllerForIndexPath:indexPath];
    if (item == nil) {
        abort();
    }
    
    id cell = [tableView dequeueReusableCellWithIdentifier:[item reuseIdentifier]];
    if (cell == nil) {
        cell = [item newCell];
    }
    else {
        SEL setCellController = @selector(setCellController:);
        if ([cell respondsToSelector:setCellController]) {
            [cell performSelector:setCellController withObject:item];
        }
    }
    if (cell == nil) {
        abort();
    }
    
    [item configCell:cell];
    [item cellDidLoad:cell];
    
    
    if ([[cell backgroundView] conformsToProtocol:@protocol(STVCellBackgroundViewProtocol)]) {
        id<STVCellBackgroundViewProtocol> background = (id<STVCellBackgroundViewProtocol>)[cell backgroundView];
        
        NSInteger sectionRowCount = [[[self.sections objectAtIndex:indexPath.section] cells] count];
        if (sectionRowCount == 1) {
            [background setPosition:kSTVCellBackgroundPositionSingle];
        }
        else if(indexPath.row == 0) {
            [background setPosition:kSTVCellBackgroundPositionTop];
        }
        else if(indexPath.row == sectionRowCount - 1) {
            [background setPosition:kSTVCellBackgroundPositionBottom];
        }
        else {
            [background setPosition:kSTVCellBackgroundPositionMiddle];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<STVCellControllerProtocol> item = [self cellControllerForIndexPath:indexPath];
    return (CGFloat)item.height;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    id<STVCellControllerProtocol> item = [self cellControllerForIndexPath:indexPath];
    if (tableView.editing) {
        return item.isEditableCell;
    }
    return item.isSwipeDeletable;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath 
{
    NSMutableArray *cells = [NSMutableArray arrayWithArray:[tableView visibleCells]];
    
    for (int i = 0; i < [cells count]; ++i) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        if ([cell.backgroundView conformsToProtocol:@protocol(STVCellBackgroundViewProtocol)]) {
            id<STVCellBackgroundViewProtocol> background = (id<STVCellBackgroundViewProtocol>)cell.backgroundView;
            if ([cells count] == 1) {
                [background setPosition:kSTVCellBackgroundPositionSingle];
            } else {
                if (i == 0) {
                    [background setPosition:kSTVCellBackgroundPositionTop];
                } else if (i == [cells count] - 1) {
                    [background setPosition:kSTVCellBackgroundPositionBottom];
                } else {
                    [background setPosition:kSTVCellBackgroundPositionMiddle];
                }
            }
        }
    }
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<STVCellControllerProtocol> item = [[[sections objectAtIndex:indexPath.section] cells] objectAtIndex:indexPath.row];
    [item didSelectCell:viewController fromTableView:[tableView cellForRowAtIndexPath:indexPath]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
