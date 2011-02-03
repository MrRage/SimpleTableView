//
//  STVActionSheetController.h
//  SimpleTableView
//
//  Created by Dustin on 1/29/11.
//  Copyright 2011 Graphics Development. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^STVDatePickerChange)(NSDate *date);
typedef void (^STVPickerIndexChange)(NSArray *dataSource);

@interface STVActionScheetController : NSObject 
<UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate> {
@private        
    UIActionSheet *actionSheet;
    STVDatePickerChange dateChagneBlock;
    NSArray *pickerSource;
    NSMutableArray *pickerIndexes;  
    STVPickerIndexChange changeBlock;
    NSDate *pickerDate;
    UIViewController *viewController;
}

@property (nonatomic, retain) UIActionSheet *actionSheet;
@property (nonatomic, retain) STVDatePickerChange dateChagneBlock;
@property (nonatomic, retain) NSArray *pickerSource;
@property (nonatomic, retain) NSMutableArray *pickerIndexes;  
@property (nonatomic, retain) STVPickerIndexChange changeBlock;
@property (nonatomic, retain) NSDate *pickerDate;
@property (nonatomic, retain) UIViewController *viewController;

- (id)initWithViewController:(UIViewController *)aViewController;

- (void)showPickerViewWithTitle:(NSString *)aTitle
                 textDataSource:(NSArray *)aPickerDataSource 
                   currentIndex:(NSArray *)aPickerIndexes 
              indexChangedBlock:(STVPickerIndexChange)aChangeBlock;

- (void)showDatePickerWithDate:(NSDate *)date
                  changedBlock:(STVDatePickerChange)aChangeBlock;

@end