//
//  NSString+String.swift
//  HEARZAP
//
//  Created by Purushoth on 30/06/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

extension String {
    // MARK: - Apply pattern
    public func toPhoneNumberFormate() -> String {
        if self.count == 10 {
            return self.replacingOccurrences(of: "(\\d{4})(\\d{3})(\\d+)", with: "$1 $2 $3", options: .regularExpression, range: nil)
        } else if self.count == 13 {
            return self.replacingOccurrences(of: "(\\d{2})(\\d{4})(\\d{3})(\\d+)", with: "$1 $2 $3 $4", options: .regularExpression, range: nil)
        }
        return self
    }
    // MARK: - Remove prefix
    func removePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    // MARK: - Remove suffix
    func removesuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    // MARK: - String compare
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
    // MARK: - Return bool value for numeric validation
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    // MARK: - Return bool value for email validation
    var isEmailValid: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    // MARK: - Return numeric validation
    func numbersFromString() -> String {
        let result = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        return result
    }
    // MARK: - Remove whitespace
    func lettersFromString() -> String {
        let result = self.trimmingCharacters(in: .whitespaces)
        return result
    }
    // MARK: - Remove special character
    func specialCharacterFromString() -> String {
        let result = self.components(separatedBy: CharacterSet.punctuationCharacters.inverted).joined(separator: "")
        return result
    }
    // MARK: - Remove whitespace and newline
    func removeEnclosedWhiteSpace() -> String {
        let result = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return result
    }
    // MARK: - Returns title case
    public func titleCase() -> String {
        return self
            .replacingOccurrences(of: "([A-Z])",
                                  with: " $1",
                                  options: .regularExpression,
                                  range: range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized // If input is in llamaCase
    }
    
    // MARK: - Returns sentense case
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    // MARK: - Returns captial case
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    // MARK: - To get date from string
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    // MARK: - Adds "+" with the string
    var checkPlusCharacter: String {
        return  self.contains("+") ? self : "+\(self)"
    }
    var checkPlus91Character: String {
        return  self.contains("+91") ? self : "+91\(self)"
    }
    // MARK: - Returns with the below allowed characters  // "!*'();:@&=+$,/?%#[] Æøå"
    var allowSpecialCharacters: String {
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%# ").inverted)
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? ""
    }
    // MARK: - Return bool value url validation based on regex
    func validateUrl () -> Bool {
        guard !contains("..") else { return false }
        let head     = "((http|https)://)?([(w|W)]{3}+\\.)?"
        let tail     = "\\.+[A-Za-z]{2,8}+(\\.)?+(/(.)*)?"
        let urlRegEx = head+"+(.)+"+tail
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        return urlTest.evaluate(with: trimmingCharacters(in: .whitespaces))
    }
    // MARK: - Adds "http" with the string
    var checkhttpCharacter: String {
        return self.contains("http") ? self : "http://\(self)"
    }
    // MARK: - html to AttributedString
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
    // MARK: - Extract video data
    func extractYoutubeIDFromLink() -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        let nsLink = self as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0, length: nsLink.length)
        let matches = regExp.matches(in: self as String, options: options, range: range)
        if let firstMatch = matches.first {
            return nsLink.substring(with: firstMatch.range)
        }
        return nil
    }
}

// MARK: - Optional String trimming
extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        return self?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
    }
}
extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor = UIColor.colorLiteral.theme_red_FF6961) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        //        // Swift 4.1 and below
        //        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
    }
    
}
