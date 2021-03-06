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
#import "STVTextEditCellView.h"

// Block Definitions
// ----------------------------------------------------------------------------

typedef NSString *(^STVTextCellFormatter)(NSString *stringValue);
typedef NSString *(^STVTextCellGetter)();
typedef void      (^STVTextCellSetter)(NSString *value);


// Class Implementation
// ----------------------------------------------------------------------------

@interface STVTextEditCellController : NSObject 
<UITextFieldDelegate, STVCellControllerProtocol> {
@private
    NSString                *reuseIdentifier;
    STVCellDidSelect        didSelectCellBlock;
    STVCellNew              newCellBlock;
    STVCellConfig           configCellBlock;
    STVCellConfig           cellDidLoadBlock;
    STVCellDelete           deleteCellBlock;
    NSInteger               height;
    BOOL                    editableCell;
    BOOL                    swipeDeletable;

    STVTextCellFormatter    textFormatter;
    STVTextCellGetter       textGetter;
    STVTextCellSetter       textSetter;
}

@property (nonatomic, copy) STVTextCellFormatter textFormatter;
@property (nonatomic, copy) STVTextCellGetter textGetter;
@property (nonatomic, copy) STVTextCellSetter textSetter;

// TextCell with Keyboard Source
+ (id)textEditCellWithPlaceholder:(NSString *)title gradientBackground:(BOOL)background;
- (id)initWithPlaceholder:(NSString *)title gradientBackground:(BOOL)background;

@end
