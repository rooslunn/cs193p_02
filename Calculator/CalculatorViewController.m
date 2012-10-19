//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Russ on 10/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEntering;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize history;
@synthesize userIsInTheMiddleOfEntering;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)clearDisplay {
//    [self.brain clearStack];
    self.display.text = @"0";
    self.userIsInTheMiddleOfEntering = NO;
}

- (void)updateHistory:(NSString *)action {
    NSArray *actions = [self.history.text componentsSeparatedByString:@" "];
    NSMutableArray *new_actions = [NSMutableArray arrayWithArray:actions];
    [new_actions addObject:action];
    if (new_actions.count > 6) {
        [new_actions removeObjectAtIndex:0];
    }
    self.history.text = [new_actions componentsJoinedByString:@" "];
}

- (IBAction)clearLastDigit {
    NSUInteger len = [self.display.text length];
    self.display.text = [self.display.text substringToIndex:len-1];
    if ([self.display.text length] == 0) {
        [self clearDisplay];
    }
}

- (IBAction)dotPressed:(UIButton *)sender {
    NSRange range = [self.display.text rangeOfString:@"."];
    if (range.location == NSNotFound) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.userIsInTheMiddleOfEntering = YES;
    }
}

- (IBAction)signDigit {
    if ([self.display.text hasPrefix:@"-"]) {
        self.display.text = [self.display.text substringFromIndex:1];
    } else {
        self.display.text = [@"-" stringByAppendingString:self.display.text];
    }
}

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
    [self.brain pushOperand:[self.display.text doubleValue]];
    [self updateHistory:self.display.text];
    [self clearDisplay];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEntering) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    [self updateHistory:operation];
}

@end
