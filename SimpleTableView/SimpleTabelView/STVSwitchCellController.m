//
//  STVSwitchCellController.m
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

#import "STVSwitchCellController.h"
#import "STVSwitchCellView.h"
#import "STVGradientBackgroundView.h"

@interface STVSwitchCellController ()
@property (nonatomic, copy) NSString *reuseIdentifier;
@end

@implementation STVSwitchCellController

@synthesize reuseIdentifier;
@synthesize didSelectCellBlock;
@synthesize newCellBlock;
@synthesize configCellBlock;
@synthesize cellDidLoadBlock;
@synthesize deleteCellBlock;
@synthesize height;
@synthesize editableCell;
@synthesize swipeDeletable;
@synthesize switchGetter;
@synthesize switchSetter;

+ (id)switchCellWithTitle:(NSString *)title gradientBackground:(BOOL)background
{
    return [[[STVSwitchCellController alloc] initWithTitle:title gradientBackground:background] autorelease];
}

- (id)initWithTitle:(NSString *)title gradientBackground:(BOOL)background
{
    if ((self = [super init])) {
        editableCell = YES;
        self.reuseIdentifier = @"STVSwitchCellController";
        
        self.editableCell = NO;
        self.swipeDeletable = NO;
        self.newCellBlock = ^(){
            STVSwitchCellView *cell;
            cell = [[[STVSwitchCellView alloc] initWithStyle:UITableViewCellStyleDefault 
                                             reuseIdentifier:reuseIdentifier] autorelease];
            cell.textLabel.text = title;
            cell.switchView = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
            cell.accessoryView = cell.switchView;
            if (background) {
                cell.textLabel.backgroundColor = [UIColor clearColor];
                cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                cell.backgroundView = [[[STVGradientBackgroundView alloc] initWithFrame:CGRectZero] autorelease];
            }
            return (id)cell;  
        };
        
        __block id fakeSelf = self;
        self.configCellBlock = ^(id configCell) {
            STVSwitchCellView *tableViewCell = (STVSwitchCellView *)configCell;
            [tableViewCell.switchView addTarget:self 
                                         action:@selector(update:) 
                               forControlEvents:UIControlEventValueChanged];
            
            tableViewCell.switchView.on = [fakeSelf switchValue];
        };
        self.height = 44;
    }
    return self;
}

- (BOOL)switchValue
{
    if (switchGetter) {
        return switchGetter();
    }
    return 0;
}
- (void)update:(UISwitch *)sender 
{
    if (switchSetter) {
        switchSetter(sender.on);
    }
}

- (id)newCell 
{
    if (newCellBlock == nil) {
        return nil;
    }
    return newCellBlock();
}

- (void)deleteCell 
{
    if (deleteCellBlock) {
        deleteCellBlock();
    }
}

- (void)cellDidLoad:(id)cell 
{
    if (cellDidLoadBlock) {
        cellDidLoadBlock(cell);
    }
}

- (void)configCell:(id)cell 
{
    if (configCellBlock) {
        configCellBlock(cell);
    }
}

- (void)didSelectCell:(id)cell fromTableView:(id)tableView; 
{
    if (didSelectCellBlock) {
        didSelectCellBlock(tableView, cell);
    }
}

- (void) dealloc 
{
    self.didSelectCellBlock = nil;
    self.newCellBlock = nil;
    self.configCellBlock = nil;
    self.deleteCellBlock = nil;
    self.cellDidLoadBlock = nil;
    self.switchGetter = nil;
    self.switchSetter = nil;
    
    [super dealloc];
}

@end
