//
//  NSString+RomanNumerals.m
//  NumerusKit
//
//  Created by Armando Di Cianno on 5/16/16.
//  Copyright © 2016 Armando Di Cianno. All rights reserved.
//

#import "NSString+RomanNumerals.h"

@implementation NSString (RomanNumerals)

- (BOOL)isValidRomanNumeral
{
    NSError *regularExpressionError = nil;
    
    /*
     Match expression reads as:
     - ^                # From the beginnging of the line.
     - (M{0,65})        # There are 65 maximum 'M' matches under our support using uint16_t as the primitive container.
     - (CM|CD|D?C{0,3}) # Then, match for 900/CM, 400/CD, or 0 to 3 100/C's following 0 or some 500/D's.
     - (XC|XL|L?X{0,3}) # Then, match for 90/XC,  40/XL,  or 0 to 3 10/X's  following 0 or some 50/L's.
     - (IX|IV|V?I{0,3}) # Then, match for 9/IX,   4/IV,   or 0 to 3 1/X's   following 0 or some 5/V's.
     - $                # To the end of the line.
     
     The options provide for case-insensitive matching.
     */
    NSString *matchExpression = @"^(M{0,65})(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$";
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:matchExpression
                                                                        options:NSRegularExpressionCaseInsensitive | NSRegularExpressionAllowCommentsAndWhitespace
                                                                          error:&regularExpressionError];
    if (regularExpressionError != nil) {
        NSAssert(false, @"Internal error: invalid regular expression provided by developer.");
    }

    NSUInteger numberOfMatches = [re numberOfMatchesInString:self
                                                     options:0
                                                       range:NSMakeRange(0, [self length])];

    // There must only be 1 match to be valid -- not 0, not >1.
    return numberOfMatches == 1;
}

@end
