//
//  STVCellController.h
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

#pragma mark -
#pragma mark Block Types

typedef id (^STVCellNew)();
typedef void (^STVCellConfig)(id cell);
typedef void (^STVCellDelete)();
typedef void (^STVCellDidSelect)(id viewController, id cell);

#pragma mark -
#pragma mark Protocol

@protocol STVCellControllerProtocol
@required
@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, copy) STVCellDidSelect  didSelectCellBlock;
@property (nonatomic, copy) STVCellNew        newCellBlock;
@property (nonatomic, copy) STVCellConfig     configCellBlock;
@property (nonatomic, copy) STVCellConfig     cellDidLoadBlock;
@property (nonatomic, copy) STVCellDelete     deleteCellBlock;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign, getter=isEditableCell) BOOL editableCell;
@property (nonatomic, assign, getter=isSwipeDeletable) BOOL swipeDeletable;

- (id)newCell;
- (void)configCell:(id)cell;
- (void)cellDidLoad:(id)cell;
- (void)didSelectCell:(id)cell fromTableView:(id)tableView;
- (void)deleteCell;
@end


#pragma mark -
#pragma mark STVCellController

@interface STVCellController : NSObject <STVCellControllerProtocol> {
@private
    NSString           *reuseIdentifier;
    STVCellDidSelect    didSelectCellBlock;
    STVCellNew          newCellBlock;
    STVCellConfig       configCellBlock;
    STVCellConfig       cellDidLoadBlock;
    STVCellDelete       deleteCellBlock;
    NSInteger           height;
    BOOL                editableCell;
    BOOL                swipeDeletable;
}

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;

// Block properties
@property (nonatomic, copy) STVCellDidSelect  didSelectCellBlock;
@property (nonatomic, copy) STVCellNew        newCellBlock;
@property (nonatomic, copy) STVCellConfig     configCellBlock;
@property (nonatomic, copy) STVCellConfig     cellDidLoadBlock;
@property (nonatomic, copy) STVCellDelete     deleteCellBlock;

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign, getter=isEditableCell) BOOL editableCell;
@property (nonatomic, assign, getter=isSwipeDeletable) BOOL swipeDeletable;

#pragma mark -
#pragma mark Class Methods 

// Cell with a custom Reuse Identifier
+ (id)cellWithReuseIdentifier:(NSString *)cellReuseIdentifier;

// Cell From a NIB
+ (id)cellWithNibName:(NSString *)nibName;

// Cell with a title, accessory and style 
+ (id)cellWithTitle:(NSString *)title 
      accessoryType:(UITableViewCellAccessoryType)accessoryType 
 gradientBackground:(BOOL)background 
      textAlignment:(UITextAlignment)textAlignment;

+ (id)cellWithTitle:(NSString *)title 
      accessoryType:(UITableViewCellAccessoryType)accessoryType 
 gradientBackground:(BOOL)background 
              style:(UITableViewCellStyle)style;

#pragma mark -
#pragma mark Method Inits Cells 

- (id)initWithTitle:(NSString *)title 
      accessoryType:(UITableViewCellAccessoryType)accessoryType 
 gradientBackground:(BOOL)background 
      textAlignment:(UITextAlignment)textAlignment;

- (id)initWithTitle:(NSString *)title 
      accessoryType:(UITableViewCellAccessoryType)accessoryType 
 gradientBackground:(BOOL)background 
              style:(UITableViewCellStyle)style;

- (id)initWithNibName:(NSString *)nibName;

- (id)initWithReuseIdentifier:(NSString *)cellReuseIdentifier;


#pragma mark -
#pragma mark Cell Methods 

// These methods execute the blocks 
- (id)newCell;
- (void)configCell:(id)cell;
- (void)cellDidLoad:(id)cell;

// Preform a didSelect on cell
- (void)didSelectCell:(id)cell fromTableView:(id)tableView;

// Delete cell
- (void)deleteCell;


@end

