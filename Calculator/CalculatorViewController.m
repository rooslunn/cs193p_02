//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Russ on 10/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEntering;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEntering;

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEntering) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEntering = YES;
    }
}
- (IBAction)enterPressed {
}

- (IBAction)operationPressed:(UIButton *)sender {
}

@end
