//
//  NSNumber+RomanNumerals.m
//  NumerusKit
//
//  Created by Armando Di Cianno on 5/16/16.
//  Copyright © 2016 Armando Di Cianno. All rights reserved.
//

#import "NSNumber+RomanNumerals.h"
#import "NSString+RomanNumerals.h"


@implementation NSNumber (RomanNumerals)

+ (NSDictionary<NSString*,NSNumber*> *)romanNumeralsLetterToNumberMap  {
    return @{ @"N" : @0,
              @"I" : @1,
              @"V" : @5,
              @"X" : @10,
              @"L" : @50,
              @"C" : @100,
              @"D" : @500,
              @"M" : @1000
              };
}

+ (NSDictionary<NSNumber*,NSString*> *)romanNumeralsNumberToLetterMap  {
    return @{ @1    : @"I",
              @4    : @"IV",
              @5    : @"V",
              @9    : @"IX",
              @10   : @"X",
              @40   : @"XL",
              @50   : @"L",
              @90   : @"XC",
              @100  : @"C",
              @400  : @"CD",
              @500  : @"D",
              @900  : @"CM",
              @1000 : @"M",
              };
}



+ (instancetype)numberWithRomanNumerals:(NSString *)value
{
    // Guard against malformed string sequences, and return early if the string itself is invalid
    if (!value.isValidRomanNumeral) {
        return nil;
    }
    
    /*
     Since we used the internal validator, we can now naively (i.e. simply and readably) parse the
     Roman numeral string, since we know that it is in a valid form.
     */

    NSDictionary<NSString*,NSNumber*> *l2nMap = NSNumber.romanNumeralsLetterToNumberMap;
    
    NSString           *str    = [value uppercaseString]; // we don't care about case, so normalize to upper-case
    __block romanInt_t  accum  = 0;
    __block romanInt_t  curMax = 0;
    __block romanInt_t  curVal = 0;
    __block BOOL        failed = NO;
    
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length)
                            options:NSStringEnumerationByComposedCharacterSequences | NSStringEnumerationReverse
                         usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop)
    {
        NSNumber *got = [l2nMap objectForKey:substring];
        if (!got) {
            failed = YES;
            *stop = YES;
        } else {
            curVal = (romanInt_t)got.unsignedShortValue;
            if (curVal >= curMax) {
                accum += curVal;
                curMax = curVal;
            } else {
                accum -= curVal;
            }
        }
    }];
    
    if (failed) {
        return nil;
    } else {
        return [self numberWithUnsignedShort:accum];
    }    
}

- (romanInt_t)romanIntValue
{
    return (romanInt_t)self.unsignedShortValue;
}

- (NSString *)romanNumeralStringValue
{
    /// Guard early-on against value that would violate the data-type contract of uint16-max
    if (self.unsignedLongLongValue > UINT16_MAX) {
        return nil;
    }
    
    /// Guard early-on against the zero-case, and just return 'N'
    if (self.romanIntValue == 0) {
        return @"N";
    }

    // a local copy of the class's roman numerals numbers to letters dictionary
    NSDictionary<NSNumber*,NSString*> *n2lMap   = NSNumber.romanNumeralsNumberToLetterMap;
    // an ordered array, high to low, of the Romans numerals we support
    NSSortDescriptor                  *high2Low = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    NSArray<NSNumber*>                *nMap     = [[n2lMap.allKeys mutableCopy] sortedArrayUsingDescriptors:@[high2Low]];
    // the string that will get returned
    NSMutableString  *curString = [NSMutableString stringWithFormat:@""];

    romanInt_t accum  = (romanInt_t)self.unsignedShortValue;
    NSUInteger nIndex = 0;
    while (accum > 0) {
        romanInt_t divisor = (romanInt_t)nMap[nIndex].unsignedShortValue;
        uint16_t   units   = accum / divisor;

        /**
         - When we have any amount of quotient > 0, add the current numeral to the return-string,
           subtract the amount from the accumulator, and continue.
         - When the quotient is zero, then increment the index of the number-value array to the next number.
         */
        if (units > 0) {
            NSString *got = [n2lMap objectForKey:@(divisor)];
            if (got) {
                [curString appendString:got];
                accum -= divisor;
            }
        } else {
            nIndex += 1;
        }
    }
    
    return curString;
}

@end
