//
//  STVTextEditCellController.m
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

#import "STVTextEditCellController.h"
#import "STVTextEditCellView.h"
#import "STVGradientBackgroundView.h"

@implementation STVTextEditCellController

@synthesize reuseIdentifier;
@synthesize didSelectCellBlock;
@synthesize newCellBlock;
@synthesize configCellBlock;
@synthesize cellDidLoadBlock;
@synthesize deleteCellBlock;
@synthesize height;
@synthesize editableCell;
@synthesize swipeDeletable;

@synthesize textFormatter;
@synthesize textGetter;
@synthesize textSetter;

#pragma mark -
#pragma mark Class Methods

+ (id)textEditCellWithPlaceholder:(NSString *)title gradientBackground:(BOOL)background 
{
    return [[[STVTextEditCellController alloc] initWithPlaceholder:title gradientBackground:background] autorelease];
}

- (id)initWithPlaceholder:(NSString *)title gradientBackground:(BOOL)background 
{
    if ((self = [super init])) {
        self.height = 44;
        reuseIdentifier = [@"STVTextEditCellController" copy];
        
        // TODO: Fix this    
        self.newCellBlock = ^() {
            STVTextEditCellView *tableViewCell = [[STVTextEditCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"STVTextEditCellView"];
            tableViewCell.opaque = YES;
            tableViewCell.textField = [[[UITextField alloc] initWithFrame:CGRectMake(20.0, 7.0, 280.0, 31.0)] autorelease];
            tableViewCell.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            tableViewCell.textField.opaque = NO;
            tableViewCell.textField.backgroundColor = [UIColor clearColor];
            [tableViewCell addSubview:tableViewCell.textField];
            
            if (background) {
                tableViewCell.backgroundView = [[[STVGradientBackgroundView alloc] initWithFrame:CGRectZero] autorelease];
            }
            return (id)tableViewCell;
        };
        
        self.configCellBlock = ^(id configCell) {
            STVTextEditCellView *tableViewCell = (STVTextEditCellView *)configCell;

            tableViewCell.textField.placeholder = title;
            tableViewCell.textField.delegate = self;
    
            if (textGetter) {
                if (textFormatter != nil) {
                    tableViewCell.textField.text = textFormatter(textGetter());
                }
                else {
                    tableViewCell.textField.text = textGetter();
                }
            }
            else {
                tableViewCell.textField.text = @"";
            }
        };
        
        self.didSelectCellBlock = ^(id sender, id tableViewCell) {
            [[tableViewCell textField] becomeFirstResponder];
        };
    }
    
    return self;
}

#pragma mark -
#pragma mark Text Field Delegates

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField 
{
    if (textGetter) {
        textField.text = textGetter();
    }
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField 
{
    if (textSetter) {
        textSetter(textField.text);
    }
    if (textFormatter) {
        textField.text = textFormatter(textField.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    if (textSetter) {
        textSetter(textField.text);
    }
    if (textFormatter) {
        textField.text = textFormatter(textField.text);
    }
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark STVCellControllerProtocol

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

- (void)dealloc 
{
    self.didSelectCellBlock = nil;
    self.newCellBlock = nil;
    self.configCellBlock = nil;
    self.deleteCellBlock = nil;
    self.cellDidLoadBlock = nil;
    self.textFormatter = nil;
    self.textGetter = nil;
    self.textSetter = nil;
    
    [super dealloc];
}

@end
