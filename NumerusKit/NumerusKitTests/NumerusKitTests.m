//
//  NumerusKitTests.m
//  NumerusKitTests
//
//  Created by Armando Di Cianno on 5/16/16.
//  Copyright © 2016 Armando Di Cianno. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NumerusKit/NumerusKit.h>


@interface NumerusKitTests : XCTestCase
@end


@implementation NumerusKitTests


/// Integer to Roman numeral

- (void)testNumberToRomanNumeralZero {
    NSNumber *n = @0;
    XCTAssertTrue([n.romanNumeralStringValue isEqualToString:@"N"]);
}

- (void)testNumberToRomanNumeralUnit {
    NSNumber *n = @90;
    XCTAssertTrue([n.romanNumeralStringValue isEqualToString:@"XC"]);
}

- (void)testNumberToRomanNumeralMaxUnsignedLong {
    NSNumber *n = @65535;
    NSString *got = n.romanNumeralStringValue;
    XCTAssertTrue(got.length == 70);               // the length of the large string produced
    XCTAssertEqual('M', [got characterAtIndex:0]); // assert starts with an 'M'
    XCTAssertTrue([got containsString:@"MDXXXV"]); // ends with this string
}

- (void)testNumberToRomanNumeralGreaterThanMaxSupported {
    NSNumber *n = @65536;
    NSString *got = n.romanNumeralStringValue;
    XCTAssertNil(got);
}

- (void)testNumberToRomanNumeralNegative{
    NSNumber *n = @(-1);
    NSString *got = n.romanNumeralStringValue;
    XCTAssertNil(got);
}

- (void)testNumberToRomanNumeralVarious {
    NSNumber *n = @1416;
    XCTAssertTrue([n.romanNumeralStringValue isEqualToString:@"MCDXVI"]);
}

- (void)testNumberToRomanNumeralMultipleThousands {
    NSNumber *n = @4016;
    XCTAssertTrue([n.romanNumeralStringValue isEqualToString:@"MMMMXVI"]);
}


/// Roman numeral validator

- (void)testValidRomanNumeralStringUnit {
    NSString *str = @"V";
    XCTAssertTrue(str.isValidRomanNumeral);
}

- (void)testValidRomanNumeralString1948 {
    NSString *str = @"MCMXLVIII";
    XCTAssertTrue(str.isValidRomanNumeral);
}

- (void)testValidRomanNumeralStringBig {
    NSString *str = @"MMMMMMMMMMMMMMCMXLVIII";
    XCTAssertTrue(str.isValidRomanNumeral);
}

- (void)testValidRomanNumeralStringTextCase {
    NSString *str = @"LvIiI";
    XCTAssertTrue(str.isValidRomanNumeral);
}

- (void)testInvalidRomanNumeralStringTooManyCs {
    NSString *str = @"MCCCC";
    XCTAssertFalse(str.isValidRomanNumeral);
}

- (void)testInvalidRomanNumeralStringBadOrder {
    NSString *str = @"DCXXL";
    XCTAssertFalse(str.isValidRomanNumeral);
}


/// Roman numeral to integer

- (void)testRomanNumeralToNumberZero {
    NSString *str = @"N";
    NSNumber *num = [NSNumber numberWithRomanNumerals:str];
    XCTAssertEqual(0, num.romanIntValue);
}

- (void)testRomanNumeralToNumberUnit {
    NSString *str = @"V";
    NSNumber *num = [NSNumber numberWithRomanNumerals:str];
    XCTAssertEqual(5, num.romanIntValue);
}

- (void)testRomanNumeralToNumber1948 {
    NSString *str = @"MCMXLVIII";
    NSNumber *num = [NSNumber numberWithRomanNumerals:str];
    XCTAssertEqual(1948, num.romanIntValue);
}

- (void)testRomanNumeralToNumberMax {
    NSString *str = ^NSString * {
        int mCount = 65;
        NSMutableString *s = [NSMutableString stringWithFormat:@""];
        for (int i=0;i<mCount;i+=1) {
            [s appendString:@"M"];
        }
        [s appendString:@"DXXXV"];
        return s;
    }();
    NSNumber *num = [NSNumber numberWithRomanNumerals:str];
    XCTAssertEqual(65535, num.romanIntValue);
}

- (void)testRomanNumeralToNumberTextCase {
    NSString *str = @"lvIiI";
    NSNumber *num = [NSNumber numberWithRomanNumerals:str];
    XCTAssertEqual(58, num.romanIntValue);
}

- (void)testRomanNumeralToNumberInvalidTooBig {
    NSString *str = ^NSString * {
        NSMutableString *s = [NSMutableString stringWithFormat:@""];
        int mCount = 66; // bad!
        for (int i=0;i<mCount;i+=1) {
            [s appendString:@"M"];
        }
        [s appendString:@"DXXXV"];
        return s;
    }();
    NSNumber *num = [NSNumber numberWithRomanNumerals:str];
    XCTAssertNil(num);
}

- (void)testRomanNumeralToNumberInvalidNotANumber {
    NSString *str = @"HELLO";
    NSNumber *num = [NSNumber numberWithRomanNumerals:str];
    XCTAssertNil(num);
}

- (void)testRomanNumeralToNumberInvalidBadNumber {
    NSString *str = @"DCCCCIIIII";
    NSNumber *num = [NSNumber numberWithRomanNumerals:str];
    XCTAssertNil(num);
}

@end
