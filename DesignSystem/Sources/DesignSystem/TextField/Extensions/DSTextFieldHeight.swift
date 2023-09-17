//
//  StrongTextFieldHeight.swift
//  
//
//  Created by Dinmukhamed on 08.06.2023.
//
import UIKit

public enum DSTextFieldHeight {
    case sum
    case text
    
    public var rawValue: CGFloat {
        switch self {
        case .sum:
            return 60
        case .text:
            return 60
        }
    }

    public var captionLabelHeight: CGFloat {
        switch self {
        case .sum:
            return 16
        case .text:
            return 16
        }
    }
}
