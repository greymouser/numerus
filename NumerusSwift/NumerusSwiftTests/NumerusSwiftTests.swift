//
//  NumerusSwiftTests.swift
//  NumerusSwiftTests
//
//  Created by Armando Di Cianno on 10/16/18.
//  Copyright © 2018 Armando Di Cianno. All rights reserved.
//

import XCTest
@testable import NumerusSwift

class NumerusSwiftTests: XCTestCase {

    // MARK: - Integer to Roman numeral

    func testNumberToRomanNumeralZero() {
        let numeral = String(roman: 0)
        let expect = "N"
        XCTAssertEqual(expect, numeral)
    }

    func testNumberToRomanNumeralUnit() {
        let numeral = String(roman: 90)
        let expect = "XC"
        XCTAssertEqual(expect, numeral)
    }

    func testNumberToRomanNumeralMaxUInt16() {
        let number = 65535
        let numeral = String(roman: number)
        let expectLength = 70
        let expectFirstChar: Character = "M"
        let expectEndsWith = "MDXXXV"
        XCTAssertEqual(expectLength, numeral?.count)
        XCTAssertEqual(expectFirstChar, numeral?.first)
        XCTAssertTrue(numeral?.hasSuffix(expectEndsWith) ?? false)
    }

    func testNumberToRomanNumeralVarious() {
        let number = 1416
        let expected = "MCDXVI"
        XCTAssertEqual(expected, String(roman: number))
    }

    func testNumberToRomanNumeralMultipleThousands() {
        let number = 4016
        let expected = "MMMMXVI"
        XCTAssertEqual(expected, String(roman: number))
    }
    
    func testUInt64Okay() {
        let numeral = "MMMMXVI"
        let expected: UInt64 = 4016
        let got = UInt64(roman: numeral)
        XCTAssertEqual(expected, got)
    }
    
    func testUInt32Okay() {
        let numeral = "MMMMXVI"
        let expected: UInt32 = 4016
        let got = UInt32(roman: numeral)
        XCTAssertEqual(expected, got)
    }
    
    func testUInt8Bad() {
        let numeral = "MMMMXVI"
        let got = UInt8(roman: numeral)
        XCTAssertNil(got)
    }
    
    func testUInt8Okay() {
        let numeral = "CCXVI"
        let expected: UInt8 = 216
        let got = UInt8(roman: numeral)
        XCTAssertEqual(expected, got)
    }
    
    func testUIntOkay() {
        let numeral = "MMMMXVI"
        let expected: UInt = 4016
        let got = UInt(roman: numeral)
        XCTAssertEqual(expected, got)
    }
    
    func testInt64Okay() {
        let numeral = "MMMMXVI"
        let expected: Int64 = 4016
        let got = Int64(roman: numeral)
        XCTAssertEqual(expected, got)
    }
    
    func testInt32Okay() {
        let numeral = "MMMMXVI"
        let expected: Int32 = 4016
        let got = Int32(roman: numeral)
        XCTAssertEqual(expected, got)
    }

    func testInt16Bad() {
        let numeral = "MMMMMMMMMM"+"MMMMMMMMMM"+"MMMMMMMMMM"+"MM"+"D"+"CC"+"L"+"X"+"V"+"III"
        let got = Int16(roman: numeral)
        XCTAssertNil(got)
    }
    
    func testInt16Okay() {
        let numeral = "MMMMMMMMMM"+"MMMMMMMMMM"+"MMMMMMMMMM"+"MM"+"D"+"CC"+"L"+"X"+"V"+"II"
        let expected = Int16.max
        let got = Int16(roman: numeral)
        XCTAssertEqual(expected, got)
    }
    
    func testInt8Bad() {
        let numeral = "CXXVIII"
        let got = Int8(roman: numeral)
        XCTAssertNil(got)
    }
    
    func testInt8Okay() {
        let numeral = "CXXVII"
        let expected: Int8 = 127
        let got = Int8(roman: numeral)
        XCTAssertEqual(expected, got)
    }
    
    func testIntOkay() {
        let numeral = "MMMMXVI"
        let expected = 4016
        let got = Int(roman: numeral)
        XCTAssertEqual(expected, got)
    }

    func testNumberToRomanNumeralNegative() {
        let number = -1
        let got = String(roman: number)
        XCTAssertNil(got)
    }
    
    // MARK: - Roman numeral validator

    func testValidRomanNumeralStringUnit() {
        let string = "V"
        XCTAssertTrue(string.isValidRomanNumeral())
    }

    func testValidRomanNumeralString1948() {
        let string = "MCMXLVIII"
        XCTAssertTrue(string.isValidRomanNumeral())
    }

    func testValidRomanNumeralStringBig() {
        let string = "MMMMMMMMMMMMMMCMXLVIII"
        XCTAssertTrue(string.isValidRomanNumeral())
    }

    func testValidRomanNumeralStringTextCase() {
        let string = "LvIiI"
        XCTAssertTrue(string.isValidRomanNumeral())
    }

    func testInvalidRomanNumeralStringTooManyCs() {
        let string = "MCCCC"
        XCTAssertFalse(string.isValidRomanNumeral())
    }

    func testInvalidRomanNumeralStringBadOrder() {
        let string = "DCXXL"
        XCTAssertFalse(string.isValidRomanNumeral())
    }
     
    // MARK: - Roman numeral to integer

    func testRomanNumeralToNumberZero() {
        let string = "N"
        let expect: UInt16 = 0
        let number = UInt16(roman: string)
        XCTAssertEqual(expect, number)
    }

    func testRomanNumeralToNumberUnit() {
        let string = "V"
        let expect: UInt16 = 5
        let number = UInt16(roman: string)
        XCTAssertEqual(expect, number)
    }

    func testRomanNumeralToNumber1948() {
        let string = "MCMXLVIII"
        let expect: UInt16 = 1948
        let number = UInt16(roman: string)
        XCTAssertEqual(expect, number)
    }

    func testRomanNumeralToNumberMax() {
        var string = String(repeating: "M", count: 65)
        string.append("DXXXV")
        let expect: UInt16 = 65535
        let number = UInt16(roman: string)
        XCTAssertEqual(expect, number)
    }

    func testRomanNumeralToNumberTextCase() {
        let string = "lvIiI"
        let expect: UInt16 = 58
        let number = UInt16(roman: string)
        XCTAssertEqual(expect, number)
    }

    func testRomanNumeralToNumberInvalidTooBig() {
        var string = String(repeating: "M", count: 66) // bad!
        string.append("DXXXV")
        let number = UInt16(roman: string)
        XCTAssertNil(number)
    }

    func testRomanNumeralToNumberInvalidNotANumber() {
        let string = "HELLO"
        let number = UInt16(roman: string)
        XCTAssertNil(number)
    }

    func testRomanNumeralToNumberInvalidBadNumber() {
        let string = "DCCCCIIIII"
        let number = UInt16(roman: string)
        XCTAssertNil(number)
    }

    func testNSString() {
        let string: NSString = "XXXIII"
        XCTAssertTrue(string.isValidRomanNumeral())
    }
}
