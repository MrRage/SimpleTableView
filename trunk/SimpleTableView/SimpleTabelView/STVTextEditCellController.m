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

@implementation STVTextEditCellController

@synthesize textFormatter;
@synthesize textGetter;
@synthesize textSetter;
@synthesize keyboardType;
@synthesize returnKey;

#pragma mark -
#pragma mark Class Methods

+ (id)textEditCellWithTitle:(NSString *)title 
{
    return [[[STVTextEditCellController alloc] textEditCellWithTitle:title] autorelease];
}

- (id)textEditCellWithTitle:(NSString *)title 
{
    if (self = [super initWithReuseIdentifier:@"STVTextEditCellController"]) {
        self.returnKey = UIReturnKeyDone;
        
        // TODO: Fix this    
        //    self.newCell = ^() {
        ////      NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        ////      STVTextEditCellView *tableViewCell = [objects objectAtIndex:0];
        ////      
        ////      return (id)tableViewCell;
        //    };
        
        self.configCellBlock = ^(id configCell) {
            STVTextEditCellView *tableViewCell = (STVTextEditCellView *)configCell;
            tableViewCell.labelField.text = title;
            
            tableViewCell.textField.delegate = self;
            tableViewCell.textField.keyboardType = keyboardType;
            tableViewCell.textField.returnKeyType = returnKey;
            
            if (textGetter != nil) {
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
        
        // Dummy Methods
        self.textGetter = ^() { return @""; };
        self.textSetter = ^(NSString *text) { };
    }
    
    return self;
}

#pragma mark -
#pragma mark Text Field Delegates

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField 
{
    textField.text = textGetter();
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField 
{
    textSetter(textField.text);
    if (textFormatter) {
        textField.text = textFormatter(textField.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    textSetter(textField.text);
    if (textFormatter) {
        textField.text = textFormatter(textField.text);
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc 
{
    self.textFormatter = nil;
    self.textGetter = nil;
    self.textSetter = nil;
    
    [super dealloc];
}

@end
