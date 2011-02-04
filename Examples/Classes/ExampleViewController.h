//
//  ExampleViewController.h
//  Example
//
//  Created by Dustin Martin on 1/25/11.
//  Copyright 2011 Graphics Development. All rights reserved.
//

#import <SimpleTabelView/SimpleTableView.h>

@interface ExampleViewController : STVTableViewController {
@private
    STVActionSheetController *actionSheetController;
}
@property (nonatomic, retain) STVActionSheetController *actionSheetController;
@end

