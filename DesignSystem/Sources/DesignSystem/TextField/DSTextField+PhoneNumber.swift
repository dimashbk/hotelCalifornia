//
//  StrongTextField+PhoneNumber.swift
//  
//
//  Created by Amanzhan Zharkynuly on 20.07.2023.
//

import Foundation

extension DSTextField {
    
    public func setPhoneNumberMask() {
        self.keyboardType = .numberPad
        let maxKzNumberCount = 11
        let maxWorldNumberCount = 15
        let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
        var hasInitialCharacter = false
        self.constantText = "+7"
        self.editingBegan = { [weak self] text in
            if !hasInitialCharacter {
                self?.self.text = "+7"
                hasInitialCharacter = true
            }
        }
        
        self.editingEnded = { [weak self] text in
            if text == "+7" || text == "+" {
                self?.self.text = ""
                hasInitialCharacter = false
            }
        }
        
        self.shouldChangeCharactersIn = { (self, range, string) in
            let text = self.text ?? ""
            var fullString = ""
            if let text = self.text, text.isEmpty {
                fullString = "+7" + (self.text ?? "") + string
            } else {
                fullString = (self.text ?? "") + string
            }
            
            if !text.hasPrefix("+7"), range.location != 0, range.location <= maxWorldNumberCount {
                return true
            } else if range.location == 0 && string.isEmpty && hasInitialCharacter {
                return false
            } else if range.location > maxWorldNumberCount, !text.hasPrefix("+7") {
                return false
            } else {
                self.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
            }
            
            return false
        }
        
        func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
            guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
            
            let range = NSString(string: phoneNumber).range(of: phoneNumber)
            var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
            
            if number.count > maxKzNumberCount {
                let maxIndex = number.index(number.startIndex, offsetBy: maxKzNumberCount)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            if shouldRemoveLastDigit {
                let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            let maxIndex = number.index(number.startIndex, offsetBy: number.count)
            let regRange = number.startIndex..<maxIndex
            
            if number.count < 3 {
                let pattern = "(\\d)(\\d{1})"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2", options: .regularExpression, range: regRange)
            } else if number.count < 4 {
                let pattern = "(\\d)(\\d{2})"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2", options: .regularExpression, range: regRange)
            } else if number.count < 5 {
                let pattern = "(\\d)(\\d{3})"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2)", options: .regularExpression, range: regRange)
            } else if number.count < 8 {
                let pattern = "(\\d)(\\d{3})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
            } else if number.count < 10 {
                let pattern = "(\\d)(\\d{3})(\\d{3})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4", options: .regularExpression, range: regRange)
            } else {
                let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
            }
            
            return "+" + number
        }
    }
}
