//
//  String+RomanNumerals.swift
//  NumerusSwift
//
//  Created by Armando Di Cianno on 10/16/18.
//  Copyright © 2018 Armando Di Cianno. All rights reserved.
//

import Foundation

extension String {
    internal static var romanToInt: [Character: UInt16] = [
        "N": 0,
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
    ]

    func isValidRomanNumeral() -> Bool {
        /*
         Match expression reads as:
         - ^                # From the beginnging of the line.
         - # Normal Roman Numerals group:
            - (M{0,65})        # There are 65 maximum 'M' matches under our support using uint16_t as the primitive container.
            - (CM|CD|D?C{0,3}) # Then, match for 900/CM, 400/CD, or 0 to 3 100/C's following 0 or some 500/D's.
            - (XC|XL|L?X{0,3}) # Then, match for 90/XC,  40/XL,  or 0 to 3 10/X's  following 0 or some 50/L's.
            - (IX|IV|V?I{0,3}) # Then, match for 9/IX,   4/IV,   or 0 to 3 1/X's   following 0 or some 5/V's.
         - N # OR - just a single N for 0
         - $                # To the end of the line.
         
         The options provide for case-insensitive matching.
         */
        let matchExpression = "^((M{0,65})(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})|N)$"
        guard let regex = try? NSRegularExpression(pattern: matchExpression, options: [.caseInsensitive,.allowCommentsAndWhitespace])
            else {
                // If we get here, this is a programmer error in the match expression
                return false
            }
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        // There must only be 1 match to be valid -- not 0, not >1.
        return matches.count == 1
    }
    
    init?(roman: Int) {
        // Guard early-on against sizing issues
        guard roman <= UInt16.max,
            roman >= UInt16.min
            else { return nil }

        // Guard early-on against the zero-case, and just return 'N'
        guard roman > 0 else {
            self.init("N")
            return
        }

        var curString = ""
        var romanArray = UInt16.intToRoman.keys.sorted { (a, b) -> Bool in
            return a > b
        }
        var accum = UInt16(roman)
        var nIndex = 0
        while (accum > 0) {
            let divisor: UInt16 = romanArray[nIndex]
            let units: UInt16 = accum / divisor
            /**
             - When we have any amount of quotient > 0, add the current numeral to the return-string,
               subtract the amount from the accumulator, and continue.
             - When the quotient is zero, then increment the index of the number-value array to the next number.
             */
            if units > 0 {
                if let got = UInt16.intToRoman[divisor] {
                    curString.append(got)
                    accum -= divisor
                }
            } else {
                nIndex += 1
            }
        }
        self.init(curString)
    }
}
