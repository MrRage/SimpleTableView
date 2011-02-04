//
//  STVActionSheetController.m
//  SimpleTableView
//
//  Created by Dustin on 1/29/11.
//  Copyright 2011 Graphics Development. All rights reserved.
//

#import "STVActionSheetController.h"

@implementation STVActionSheetController

@synthesize actionSheet;
@synthesize dateChagneBlock;
@synthesize pickerSource;
@synthesize pickerIndexes;
@synthesize changeBlock;
@synthesize pickerDate;
@synthesize viewController;

- (id)initWithViewController:(UIViewController *)aViewController 
{
    if ((self = [super init])) {
        self.viewController = aViewController;
    }
    return self;
}

- (void)showPickerViewWithTitle:(NSString *)aTitle
                 textDataSource:(NSArray *)aPickerDataSource 
                   currentIndex:(NSArray *)aPickerIndexes 
              indexChangedBlock:(STVPickerIndexChange)aChangeBlock
{
    self.changeBlock = aChangeBlock;
    self.pickerSource = aPickerDataSource;
    self.pickerIndexes = [[aPickerIndexes mutableCopy] autorelease];
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    
    for (int component = 0; component < [pickerIndexes count]; component++) {
        int row = [(NSNumber *)[pickerIndexes objectAtIndex:component] intValue];
        [pickerView selectRow:row inComponent:component animated:NO];
    }
    
    UIToolbar *aToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    aToolBar.barStyle = UIBarStyleBlackOpaque;
    [aToolBar sizeToFit];
    
    aToolBar.barStyle = UIBarStyleBlackOpaque;
    [aToolBar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = nil;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissPickerViewWithCancel)];
    [barItems addObject:cancelButton];
    [cancelButton release];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    [flexSpace release];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    [flexSpace release];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPickerViewWithDone)];
    [barItems addObject:doneButton];
    [doneButton release];
    
    [aToolBar setItems:barItems animated:YES];
    
    [actionSheet addSubview:aToolBar];
    [actionSheet addSubview:pickerView];
    [actionSheet showInView:self.viewController.view];
    [actionSheet setBounds:CGRectMake(0,0,320, 464)];
    
    [pickerView release];
    [aToolBar release];
}

- (void)showDatePickerWithDate:(NSDate *)date
                  changedBlock:(STVDatePickerChange)aChangeBlock;
{
    self.dateChagneBlock = aChangeBlock;
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    UIDatePicker *pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    pickerView.date = date;
    [pickerView addTarget:self action:@selector(updateDateFromDatePicker:) forControlEvents:UIControlEventValueChanged];
    
    UIToolbar *aToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    aToolBar.barStyle = UIBarStyleBlackOpaque;
    [aToolBar sizeToFit];
    
    aToolBar.barStyle = UIBarStyleBlackOpaque;
    [aToolBar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = nil;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissPickerViewWithCancel)];
    [barItems addObject:cancelButton];
    [cancelButton release];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    [flexSpace release];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    [flexSpace release];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPickerViewWithDone)];
    [barItems addObject:doneButton];
    [doneButton release];
    
    [aToolBar setItems:barItems animated:YES];
    
    [actionSheet addSubview:aToolBar];
    [actionSheet addSubview:pickerView];
    [actionSheet showInView:self.viewController.view];
    [actionSheet setBounds:CGRectMake(0,0,320, 464)];
    
    [pickerView release];
    [aToolBar release];
}

- (void)dismissPickerViewWithCancel 
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    [pickerSource release];
    [pickerIndexes release];
    
    if (changeBlock) {
        _Block_release(changeBlock);
        changeBlock = nil;
    }
    if (dateChagneBlock != nil) {
        _Block_release(dateChagneBlock);
        dateChagneBlock = nil;
    }
}

- (void)dismissPickerViewWithDone 
{
    if (changeBlock != nil) {
        changeBlock([[pickerIndexes copy] autorelease]);
        _Block_release(changeBlock);
        changeBlock = nil;
    }
    if (dateChagneBlock != nil) {
        dateChagneBlock(pickerDate);
        _Block_release(dateChagneBlock);
        dateChagneBlock = nil;
    }
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    [pickerSource release];
    [pickerIndexes release];
    pickerSource = nil;
    pickerIndexes = nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{
    NSNumber *number = [NSNumber numberWithInt:row];
    [pickerIndexes replaceObjectAtIndex:component withObject:number];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
    return [[pickerSource objectAtIndex:component] objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView 
{
    return [pickerSource count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
    return [[pickerSource objectAtIndex:component] count];
}

- (void)updateDateFromDatePicker:(UIDatePicker *)picker 
{
    [pickerDate release];
    pickerDate = [picker.date retain];
}
@end