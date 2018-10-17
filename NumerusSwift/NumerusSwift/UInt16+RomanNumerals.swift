//
//  UInt16+RomanNumerals.swift
//  NumerusSwift
//
//  Created by Armando Di Cianno on 10/16/18.
//  Copyright © 2018 Armando Di Cianno. All rights reserved.
//

extension UInt16 {
    internal static var intToRoman: [UInt16: String] = [
        1    : "I",
        4    : "IV",
        5    : "V",
        9    : "IX",
        10   : "X",
        40   : "XL",
        50   : "L",
        90   : "XC",
        100  : "C",
        400  : "CD",
        500  : "D",
        900  : "CM",
        1000 : "M"
    ]
    
    init?(roman string: String) {
        let string = string.uppercased()
        guard string.isValidRomanNumeral() else { return nil }
        
        // Since we used the internal validator, we can now naively (i.e. simply and readably)
        // parse the Roman numeral string, since we know that it is in a valid form.
        var accum: UInt16 = 0
        var curMax: UInt16  = 0
        var curVal: UInt16  = 0
        for (_, c) in string.reversed().enumerated() {
            if let got = String.romanToInt[c] {
                curVal = got
                if (curVal >= curMax) {
                    accum += curVal
                    curMax = curVal
                } else {
                    accum -= curVal
                }
            } else {
                return nil
            }
        }
        self.init(integerLiteral: accum)
    }
}

extension UInt64 {
    init?(roman string: String) {
        guard let number = UInt16(roman: string) else { return nil }
        self.init(number)
    }
}

extension UInt32 {
    init?(roman string: String) {
        guard let number = UInt16(roman: string) else { return nil }
        self.init(number)
    }
}

extension UInt8 {
    init?(roman string: String) {
        guard let number = UInt16(roman: string) else { return nil }
        guard number <= UInt8.max else { return nil }
        self.init(number)
    }
}

extension UInt {
    init?(roman string: String) {
        guard let number = UInt16(roman: string) else { return nil }
        self.init(number)
    }
}

extension Int64 {
    init?(roman string: String) {
        guard let number = UInt16(roman: string) else { return nil }
        self.init(number)
    }
}

extension Int32 {
    init?(roman string: String) {
        guard let number = UInt16(roman: string) else { return nil }
        self.init(number)
    }
}

extension Int16 {
    init?(roman string: String) {
        guard let number = UInt16(roman: string) else { return nil }
        guard number <= Int16.max else { return nil }
        self.init(number)
    }
}

extension Int8 {
    init?(roman string: String) {
        guard let number = UInt16(roman: string) else { return nil }
        guard number <= Int8.max else { return nil }
        self.init(number)
    }
}

extension Int {
    init?(roman string: String) {
        guard let number = UInt16(roman: string) else { return nil }
        self.init(number)
    }
}
