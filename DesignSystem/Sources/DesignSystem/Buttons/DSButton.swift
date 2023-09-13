//
//  DSButton.swift
//  
//
//  Created by Dinmukhamed on 13.09.2023.
//

import UIKit

public enum DSButtonColorType {
    case primary, secondary, plain
}

open class DSButton: HotelCaliforniaButton {
    struct ColorPalette {
        let background: UIColor
        let content: UIColor
    }

    private let colorType: DSButtonColorType
    private var colorPalette = [ButtonStates: ColorPalette]()

    public init(height: ButtonHeight = .M,
         colorType: DSButtonColorType,
         leftImage: UIImage? = nil,
         titleText: String? = nil) {
        self.colorType = colorType
        super.init(
            height: height,
            leftImage: leftImage,
            titleText: titleText
        )
        self.buttonState = .default
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureState() {
        configurePalette()
        switch buttonState {
        case .default:
            setColors(colorPalette[.default]!)
            alpha = 1
            isUserInteractionEnabled = true
        case .hover:
            setColors(colorPalette[.hover]!)
            alpha = 1
            isUserInteractionEnabled = true
        case .disabled:
            setColors(colorPalette[.disabled]!)
            alpha = 0.64
            isUserInteractionEnabled = false
        }
    }

    private func configurePalette() {
        switch colorType {
        case .primary:
            colorPalette = [.default: .init(background: Color.mainBlue,
                                            content: .white),
                            .hover: .init(background: Color.mainBlue,
                                          content: .white),
                            .disabled: .init(background: Color.mainBlue,
                                             content: .white)]
        case .secondary:
            colorPalette = [.default: .init(background: Color.mainBlue,
                                            content: Color.mainBlue),
                            .hover: .init(background: Color.mainBlue,
                                          content: Color.mainBlue),
                            .disabled: .init(background: Color.mainBlue,
                                             content: Color.mainBlue)]
        case .plain:
            colorPalette = [.default: .init(background: .clear,
                                            content: Color.mainBlue),
                            .hover: .init(background: .clear,
                                          content: Color.mainBlue),
                            .disabled: .init(background: .clear,
                                             content: Color.mainBlue)]
        }
    }

    private func setColors(_ colors: ColorPalette) {
        backgroundColor = colors.background
        titleLabel.textColor = colors.content
        leftImageView.image = leftImageView.image?.withRenderingMode(.alwaysTemplate)
        leftImageView.tintColor = colors.content
        activityIndicator.color = colors.content
    }
}
