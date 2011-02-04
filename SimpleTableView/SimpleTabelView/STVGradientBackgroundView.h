//
//  STVGradientCellBackground.h
//  SimpleTableView
//
//  Inspired by Matt Coneybeare blog:
//    http://code.coneybeare.net/how-to-make-custom-drawn-gradient-backgrounds
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

typedef enum STVCellBackgroundPosition 
{
    kSTVCellBackgroundPositionSingle = 0,
    kSTVCellBackgroundPositionTop, 
    kSTVCellBackgroundPositionBottom,
    kSTVCellBackgroundPositionMiddle
} STVCellBackgroundPosition;

@protocol STVCellBackgroundViewProtocol
@property (nonatomic, assign) STVCellBackgroundPosition position;
@end


@interface STVGradientBackgroundView : UIView 
<STVCellBackgroundViewProtocol> {
@private  
    STVCellBackgroundPosition position;
}

@property (nonatomic, assign) STVCellBackgroundPosition position;

@end
