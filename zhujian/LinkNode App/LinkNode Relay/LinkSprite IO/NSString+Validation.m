//
//  NSString+Validation.m
//  MySnapCam
//
//  Created by Timothy Ritchey on 9/9/15.
//  Copyright (c) 2015 MySnapCam. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isValidEmail {

    NSString *pattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:nil];
    NSUInteger matches = [regex numberOfMatchesInString:self
                                                options:0
                                                  range:NSMakeRange(0, self.length)];
    return (matches > 0);

}

@end
