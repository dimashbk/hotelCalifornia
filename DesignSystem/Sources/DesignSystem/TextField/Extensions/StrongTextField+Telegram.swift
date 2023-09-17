//
//  StrongTextField+Telegram.swift
//  
//
//  Created by Amanzhan Zharkynuly on 20.07.2023.
//

import Foundation

extension DSTextField {
    public func setTelegramMask() {
        var hasInitialCharacter = false
        self.constantText = "@"
        self.editingBegan = { [weak self] text in
            if !hasInitialCharacter {
                self?.self.text = "@"
                hasInitialCharacter = true
            }
        }
        
        self.editingEnded = { [weak self] text in
            if text == "@" {
                self?.self.text = ""
                hasInitialCharacter = false
            }
        }
        
        self.shouldChangeCharactersIn = { (self, range, string) in
            if range.location == 0 && string.isEmpty && hasInitialCharacter {
                return false
            }
            return true
        }
    }
}
