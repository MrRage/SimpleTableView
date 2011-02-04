//
//  STVCurrencyFormatter.m
//  SimpleTableView
//
//  Created on 11/20/10.
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

#import "STVCurrencyFormatter.h"

@implementation STVCurrencyFormatter

@synthesize currencyFormatter, roundingBehavior, stringFormatter;

- (id)init 
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}


- (id)initWithPrecision:(BOOL)value 
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+sharedFormatter 
{
    static STVCurrencyFormatter* formatter = nil;
    if (formatter == nil) {
        formatter = [[STVCurrencyFormatter alloc] initWithPrecision:NO];
    }
    return formatter;
}

+sharedPrecisionFormatter 
{
    static STVCurrencyFormatter* formatter = nil;
    if (formatter == nil) {
        formatter = [[STVCurrencyFormatter alloc] initWithPrecision:YES];
    }
    return formatter;
}

- (NSDecimalNumber *)decimalNumberFromString:(NSString *)string 
{
    NSDecimalNumber *decimalNumber = (NSDecimalNumber *)[self.currencyFormatter numberFromString:string];
    if (decimalNumber == nil) {
        decimalNumber = [NSDecimalNumber decimalNumberWithString:string];
    }
    if ([decimalNumber isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    if (roundingBehavior) {
        return [decimalNumber decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    }
    else 
        return decimalNumber;
}

- (NSString *)stringFromDecimalNumber:(NSDecimalNumber *)number 
{
    if ([number isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return @"";
    }
    
    NSString *formattedString = [self.currencyFormatter stringFromNumber:number];
    if (formattedString == nil) {
        return @"";
    }
    return formattedString;
}

- (NSString *)stripFormatting:(NSDecimalNumber *)number 
{
    return nil;
}

- (STVCurrencyStringFormatter) stringFormatter 
{
    __block STVCurrencyFormatter* formatterBlock = [STVCurrencyFormatter sharedFormatter];
    STVCurrencyStringFormatter formatter = ^(NSString *text) {
        
        NSDecimalNumber *number = [formatterBlock decimalNumberFromString:text];
        if (number != nil) {
            NSString *output = [formatterBlock stringFromDecimalNumber:number];
            if ([@"NaN" isEqualToString:output]) {
                return @"";
            }
            else {
                return output;
            }
        }
        return @"";
    };
    return [[formatter copy] autorelease];
}

@end
