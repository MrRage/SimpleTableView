//
//  STVTableViewController.m
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

#import "STVTableViewController.h"

#import "STVSection.h"
#import "STVTableViewDataSource.h"
#import "STVCellController.h"

@implementation STVTableViewController

@synthesize dataSource;

#pragma mark -
#pragma mark Initlization

- (id)init 
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder 
{
    if ((self = [super initWithCoder:aDecoder])) {
        dataSource = [[STVTableViewDataSource alloc] initWithViewController:self];
        self.tableView.dataSource = dataSource;
        self.tableView.delegate = dataSource;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style 
{
    if ((self = [super initWithStyle:style])) {
        dataSource = [[STVTableViewDataSource alloc] initWithViewController:self];
        self.tableView.dataSource = dataSource;
        self.tableView.delegate = dataSource;
    }
    return self;
}




#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (void)viewDidUnload 
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc 
{
    [dataSource release];
    
    [super dealloc];
}


@end
