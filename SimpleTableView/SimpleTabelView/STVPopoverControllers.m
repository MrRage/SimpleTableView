//
//  STVViewController.m
//  SimpleTableView
//
//  Created by Dustin Martin on 1/27/11.
//  Copyright 2011 Graphics Development. All rights reserved.
//

#import "STVPopoverControllers.h"


#pragma mark -
#pragma mark Popover Controllers

@implementation STVPopoverControllers

// Display Notifications 
// -----------------------------
- (void)stvShowPickerViewWithTitle:(NSString *)aTitle 
                    textDataSource:(NSArray *)aPickerDataSource 
                      currentIndex:(NSArray *)aPickerIndexes 
                 indexChangedBlock:(STVPickerIndexChange)aChangeBlock
{
    // DO nothing right now
}

- (void)stvShowDatePickerWithDate:(NSDate *)date 
                     changedBlock:(STVDatePickerChange)aChangeBlock
{
    
}

@end
