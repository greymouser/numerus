//
//  NSString+RomanNumerals.h
//  NumerusKit
//
//  Created by Armando Di Cianno on 5/16/16.
//  Copyright © 2016 Armando Di Cianno. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (RomanNumerals)

/// Returns YES if and only if the entire string comprises a valid Roman numeral sequence.
- (BOOL)isValidRomanNumeral;

@end
