//
//  STVViewController.h
//  SimpleTableView
//
//  Created by Dustin Martin on 1/27/11.
//  Copyright 2011 Graphics Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STVActionSheetController.h"


@interface UIViewController : (STVPopoverControllers) 

// Show Picker View Popover Controllers
// -----------------------------
- (void)stvShowPickerViewWithTitle:(NSString *)aTitle 
                    textDataSource:(NSArray *)aPickerDataSource 
                      currentIndex:(NSArray *)aPickerIndexes 
                 indexChangedBlock:(STVPickerIndexChange)aChangeBlock;

- (void)stvShowDatePickerWithDate:(NSDate *)date 
                     changedBlock:(STVDatePickerChange)aChangeBlock;

@end
