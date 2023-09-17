//
//  StrongTextFieldConfiguration.swift
//  
//
//  Created by Dinmukhamed on 08.06.2023.
//

import UIKit

public struct DSTextFieldConfiguration {
    
    let placeholder: String?
    let leftImage: UIImage?
    let rightImage: UIImage?
    let keyBoardType: UIKeyboardType

    public init(placeholder: String? = nil,
                suffix: String? = nil,
                leftImage: UIImage? = nil,
                rightImage: UIImage? = nil,
                keyBoardType: UIKeyboardType = .default) {

        self.placeholder = placeholder
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.keyBoardType = keyBoardType
    }
}
