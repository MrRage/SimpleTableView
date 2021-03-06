//
//  ExampleViewController.m
//  Example
//
//  Created by Dustin Martin on 1/25/11.
//  Copyright 2011 Graphics Development. All rights reserved.
//

#import "ExampleViewController.h"

@implementation ExampleViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"SimpleTableView Examples";
    
    //
    // TableViews are comprised of sections and rows.  So we use STVTabelViewSection to represent 
    // sections.
    //
    STVSection *section;
    
    //
    // Each Cell in our sections needs to have a cell controller. Cell controllers handle the loading 
    // and unloading of the data for that cell.  Cell controllers don't have any means of storing data
    // built in, but you can extend them and include the necessary properties to save cell data.  
    //
    // However... most of the time you will want to keep your data storeage at the view controller 
    // level and use the blocks stored in the cells to update that data.  These are the three built
    // in types of cell controllers.  STVCellController is the generic cell controller, 
    // STVSwitchCellController gives you a switch accessory, and finaly STVTextEditCellController 
    // gives you a ready to use text edit cell.
    //
    STVCellController *cell;
    STVSwitchCellController *switchCell;
    STVTextEditCellController *textEditCell;
    
    //
    // Passing a nil title, or @"" tells the table view controller not to display a section header.
    //
    section = [STVSection sectionWithTitle:nil];
    
    // 
    // Here are are creating a basic cell with a gradient, styleValue2 and a disclosure indicator. 
    // We are also setting its didLoadBlock to set the detailedTextLabel.  The STVCellController 
    // auto generated for us a block to build and configure the cell's title.
    //
    // We are also going to set a didSelect on this cell so that it can update a value for us.  
    // notice our use of the __block in this example.
    //
    cell = [STVCellController cellWithTitle:@"Value2Cell" 
                              accessoryType:UITableViewCellAccessoryDisclosureIndicator
                         gradientBackground:YES
                                      style:UITableViewCellStyleValue2];
    
    cell.cellDidLoadBlock = ^(UITableViewCell *myCell) {
        myCell.detailTextLabel.text = @"54";
    };
    
    __block int counter = 1;
    cell.didSelectCellBlock = ^(id viewController, UITableViewCell *myCell) {
        myCell.detailTextLabel.text = [[NSNumber numberWithInt:(++counter * 54)] stringValue];
    };
    
    //
    // Now that we have a complete cell, lets add it to our section
    //
    [section addCell:cell];
    
    //
    // We are making another cell, this time with textAlignment.  If your using text alignment then 
    // the only valid cell you can use is the default one, text alignment is ignored in all other 
    // cell types.
    //
    // This cell also creates another TableViewController with 100 cells and pushes it onto the
    // view stack.  Its interesting that note that it dosn't take much code to create a tableview 
    // especially if all you want to do is display a list of information.
    //
    cell = [STVCellController cellWithTitle:@"100 Cells" 
                              accessoryType:UITableViewCellAccessoryNone
                         gradientBackground:YES 
                              textAlignment:UITextAlignmentCenter];
    cell.didSelectCellBlock = ^(id viewController, id cell) {
        STVTableViewController *tableViewController = [[STVTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        STVSection *tableViewSection = [STVSection sectionWithTitle:nil];
        for (int i = 0; i < 100; i++) {
            [tableViewSection.cells addObject:[STVCellController cellWithTitle:[NSString stringWithFormat:@"Cell %d of 100",i+1] 
                                                                 accessoryType:UITableViewCellAccessoryNone 
                                                            gradientBackground:YES 
                                                                 textAlignment:UITextAlignmentCenter]];
        }
        [tableViewController.dataSource addSection:tableViewSection];
        [[viewController navigationController] pushViewController:tableViewController animated:YES];
        [tableViewController release];
    };
    [section addCell:cell];
    
    // 
    // Now we will add our section to the data source.
    //
    [self.dataSource addSection:section];
    
    // Title section
    section = [STVSection sectionWithTitle:@"This is a title"];
    switchCell = [STVSwitchCellController switchCellWithTitle:@"Switching" gradientBackground:YES];
    switchCell.switchGetter = ^() {
        return NO;
    };
    
    [section addCell:switchCell];
    [self.dataSource addSection:section];
    
    //
    // Here we setup a TextEditCell for both secure, and none secure information.
    // Notice that we used 
    //
    section = [STVSection sectionWithTitle:@"Login"];
    textEditCell = [STVTextEditCellController textEditCellWithPlaceholder:@"Login" gradientBackground:YES];
    textEditCell.cellDidLoadBlock = ^(STVTextEditCellView *cellView) {
        cellView.textField.secureTextEntry = NO;
        cellView.textField.keyboardType = UIKeyboardTypeAlphabet;
        cellView.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    };
    [section addCell:textEditCell];
    
    textEditCell = [STVTextEditCellController textEditCellWithPlaceholder:@"Password" gradientBackground:YES];
    textEditCell.cellDidLoadBlock = ^(STVTextEditCellView *cellView) {
        cellView.textField.secureTextEntry = YES;
        cellView.textField.keyboardType = UIKeyboardTypeAlphabet;
        cellView.textField.clearButtonMode = UITextFieldViewModeNever;
    };
    [section addCell:textEditCell];
    
    textEditCell = [STVTextEditCellController textEditCellWithPlaceholder:@"PIN" gradientBackground:YES];
    textEditCell.cellDidLoadBlock = ^(STVTextEditCellView *cellView) {
        cellView.textField.secureTextEntry = YES;
        cellView.textField.keyboardType = UIKeyboardTypeNumberPad;
        cellView.textField.clearButtonMode = UITextFieldViewModeNever;
    };
    
    [section addCell:textEditCell];
    [self.dataSource addSection:section];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
