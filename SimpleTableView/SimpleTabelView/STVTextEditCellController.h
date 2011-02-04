//
//  STVTextEditCellController.h
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


// Block Definitions
// ----------------------------------------------------------------------------

typedef NSString *(^STVTextCellFormatter)(NSString *stringValue);
typedef NSString *(^STVTextCellGetter)();
typedef void      (^STVTextCellSetter)(NSString *value);


// Class Implementation
// ----------------------------------------------------------------------------

@interface STVTextEditCellController : STVCellController 
<UITextFieldDelegate> {
@private
    STVTextCellFormatter textFormatter;
    STVTextCellGetter textGetter;
    STVTextCellSetter textSetter;
    UIKeyboardType keyboardType;
    UIReturnKeyType returnKey;
}

@property (nonatomic, copy) STVTextCellFormatter textFormatter;
@property (nonatomic, copy) STVTextCellGetter textGetter;
@property (nonatomic, copy) STVTextCellSetter textSetter;

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UIReturnKeyType returnKey;

// TextCell with Keyboard Source
+ (id)textEditCellWithTitle:(NSString *)title;
- (id)textEditCellWithTitle:(NSString *)title;

@end
