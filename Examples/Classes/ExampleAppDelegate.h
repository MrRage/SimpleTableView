//
//  ExampleAppDelegate.h
//  Example
//
//  Created by Dustin Martin on 1/25/11.
//  Copyright 2011 Graphics Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExampleViewController;

@interface ExampleAppDelegate : NSObject 
<UIApplicationDelegate> {
@private
    UIWindow *window;
    UINavigationController *navigation;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigation;

@end

