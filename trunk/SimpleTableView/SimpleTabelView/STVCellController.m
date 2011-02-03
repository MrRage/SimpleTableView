//
//  STVCellController.m
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

#import "STVCellController.h"
#import "STVGradientBackgroundView.h"

@implementation STVCellController

@synthesize reuseIdentifier;
@synthesize didSelectCellBlock;
@synthesize newCellBlock;
@synthesize configCellBlock;
@synthesize cellDidLoadBlock;
@synthesize deleteCellBlock;
@synthesize height;
@synthesize editableCell;
@synthesize swipeDeletable;

+ (id)cellWithTitle:(NSString *)title 
      accessoryType:(UITableViewCellAccessoryType)accessoryType 
 gradientBackground:(BOOL)background 
      textAlignment:(UITextAlignment)textAlignment
{
    return [[[STVCellController alloc] initWithTitle:title 
                                       accessoryType:accessoryType 
                                  gradientBackground:background 
                                       textAlignment:textAlignment] autorelease];
}

+ (id)cellWithTitle:(NSString *)title 
      accessoryType:(UITableViewCellAccessoryType)accessoryType 
 gradientBackground:(BOOL)background 
              style:(UITableViewCellStyle)style
{
    return [[[STVCellController alloc] initWithTitle:title 
                                       accessoryType:accessoryType 
                                  gradientBackground:background 
                                               style:style] autorelease];
}

+ (id)cellWithNibName:(NSString *)nibName 
{
    return [[[STVCellController alloc] initWithNibName:nibName] autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)cellReuseIdentifier 
{
    return [[[STVCellController alloc] initWithReuseIdentifier:cellReuseIdentifier] autorelease];
}

- (id)initWithTitle:(NSString *)title 
      accessoryType:(UITableViewCellAccessoryType)accessoryType 
 gradientBackground:(BOOL)background 
      textAlignment:(UITextAlignment)textAlignment
{
    self = [super init];
    if (self) {
        editableCell = YES;
        reuseIdentifier = @"BasicCellUITableViewCellStyleDefault";
        
        self.editableCell = NO;
        self.swipeDeletable = NO;
        self.newCellBlock = ^(){
            UITableViewCell *cell;
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:reuseIdentifier] autorelease];
            if (background) {
                cell.textLabel.backgroundColor = [UIColor clearColor];
                cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                cell.backgroundView = [[[STVGradientBackgroundView alloc] initWithFrame:CGRectZero] autorelease];
            }
            return (id)cell;  
        };
        
        self.configCellBlock = ^(id cell) {
            UILabel *label = [cell textLabel];
            label.text = title;
            label.textAlignment = textAlignment;
            [cell setAccessoryType:accessoryType];
        };
        
        self.height = 44;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title 
      accessoryType:(UITableViewCellAccessoryType)accessoryType 
 gradientBackground:(BOOL)background 
              style:(UITableViewCellStyle)style 
{
    self = [super init];
    if (self) {
        editableCell = YES;
        reuseIdentifier = [[NSString alloc] initWithFormat:@"BasicCell%d",style];
        
        self.editableCell = NO;
        self.swipeDeletable = NO;
        self.newCellBlock = ^(){
            UITableViewCell *cell;
            cell = [[[UITableViewCell alloc] initWithStyle:style 
                                           reuseIdentifier:reuseIdentifier] autorelease];
            if (background) {
                cell.textLabel.backgroundColor = [UIColor clearColor];
                cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                cell.backgroundView = [[[STVGradientBackgroundView alloc] initWithFrame:CGRectZero] autorelease];
            }
            return (id)cell;  
        };
        
        self.configCellBlock = ^(id cell) {
            UILabel *label = [cell textLabel];
            label.text = title;
            [cell setAccessoryType:accessoryType];
        };
        
        self.height = 44;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibName 
{
    self = [super init];
    if (self) {
        editableCell = YES;
        reuseIdentifier = [nibName copy];
        
        self.editableCell = NO;
        self.swipeDeletable = NO;
        self.newCellBlock = ^() { 
            NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
            return [objects objectAtIndex:0];
        };
        UITableViewCell *cell = newCellBlock();
        self.height = cell.frame.size.height;
    }
    return self;
}

- (id)initWithReuseIdentifier:(NSString *)cellReuseIdentifier 
{
    self = [super init];
    if (self) {
        editableCell = YES;
        reuseIdentifier = [cellReuseIdentifier copy];
        
        self.editableCell = NO;
        self.swipeDeletable = NO;
        self.newCellBlock = ^(){
            UITableViewCell *cell;
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:reuseIdentifier] autorelease];
            return (id)cell;  
        };
        self.height = 44;
    }
    return self;
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
        didSelectCellBlock(cell, tableView);
    }
}

- (void) dealloc 
{
    self.didSelectCellBlock = nil;
    self.newCellBlock = nil;
    self.configCellBlock = nil;
    self.deleteCellBlock = nil;
    self.cellDidLoadBlock = nil;
    
    [super dealloc];
}
@end
