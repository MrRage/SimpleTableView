//
//  STVSwitchCellController.h
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

typedef BOOL (^STVSwitchCellGetter)();
typedef void (^STVSwitchCellSetter)(BOOL value);

@interface STVSwitchCellController : NSObject
<STVCellControllerProtocol> {
@private
    NSString            *reuseIdentifier;
    STVCellDidSelect    didSelectCellBlock;
    STVCellNew          newCellBlock;
    STVCellConfig       configCellBlock;
    STVCellConfig       cellDidLoadBlock;
    STVCellDelete       deleteCellBlock;
    NSInteger           height;
    BOOL                editableCell;
    BOOL                swipeDeletable;
    STVSwitchCellGetter switchGetter;
    STVSwitchCellSetter switchSetter;
}

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;

@property (nonatomic, copy) STVCellDidSelect  didSelectCellBlock;
@property (nonatomic, copy) STVCellNew        newCellBlock;
@property (nonatomic, copy) STVCellConfig     configCellBlock;
@property (nonatomic, copy) STVCellConfig     cellDidLoadBlock;
@property (nonatomic, copy) STVCellDelete     deleteCellBlock;

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign, getter=isEditableCell) BOOL editableCell;
@property (nonatomic, assign, getter=isSwipeDeletable) BOOL swipeDeletable;

@property (nonatomic, copy) STVSwitchCellGetter switchGetter;
@property (nonatomic, copy) STVSwitchCellSetter switchSetter;

- (id)newCell;
- (void)configCell:(id)cell;
- (void)cellDidLoad:(id)cell;
- (void)didSelectCell:(id)cell fromTableView:(id)tableView;
- (void)deleteCell;

+ (id)switchCellWithTitle:(NSString *)title gradientBackground:(BOOL)background;
- (id)initWithTitle:(NSString *)title gradientBackground:(BOOL)background;

- (void)update:(UISwitch *)sender;
- (BOOL)switchValue;
@end
