//
//  NSNumber+RomanNumerals.h
//  NumerusKit
//
//  Created by Armando Di Cianno on 5/16/16.
//  Copyright © 2016 Armando Di Cianno. All rights reserved.
//

#import <Foundation/Foundation.h>

/// A type declaring that roman numerals supported will be between 0...UINT16_MAX
typedef uint16_t romanInt_t;


@interface NSNumber (RomanNumerals)

+ (instancetype)numberWithRomanNumerals:(NSString *)value;

@property (readonly) NSString *romanNumeralStringValue;

- (romanInt_t)romanIntValue;

@end
