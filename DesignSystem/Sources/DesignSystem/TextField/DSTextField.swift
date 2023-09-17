//
//  File.swift
//  
//
//  Created by Dinmukhamed on 08.06.2023.
//

import UIKit
import SnapKit

open class DSTextField: DSInput {
    override public init() {
        super.init()
        self.inputHeight = .sum
    }

    override func configureUI() {
        super.configureUI()
        configureTextField()
        configureLeftImage()
        configureRightImage()
        configurePlaceholderLabel()
    }

    override public func configure(inputConfiguration: DSTextFieldConfiguration) {
        self.configuration = inputConfiguration
        self.inputState = .default
        if inputConfiguration.keyBoardType == .default {
            floatingTextField.keyboardType = .default
        } else {
            floatingTextField.keyboardType = inputConfiguration.keyBoardType
        }
        configureUI()
    }

    func configureLeftImage() {
        guard let leftImage = configuration.leftImage else { return }
        leftImageView.image = leftImage
        leftImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    func configureRightImage() {
        rightImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        guard let rightImage = configuration.rightImage else { return }
        rightImageView.image = rightImage
    }

    func configureTextField() {
        textFieldContainerView.backgroundColor = UIColor.secondarySystemBackground
        textFieldContainerView.layer.cornerRadius = 12
        [textFieldContainerView, captionLabel].forEach { backgroundView.addSubview($0) }
        textFieldContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        textFieldContainerView.addSubview(leftImageView)
        textFieldContainerView.addSubview(rightImageView)
        textFieldContainerView.addSubview(floatingTextField)

        floatingTextField.snp.makeConstraints { make in
            make.left.equalTo(leftImageView.snp.right).offset(8)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(rightImageView.snp.left).offset(8)
        }
    }
  
    func configurePlaceholderLabel() {
        guard let placeholder = configuration.placeholder else { return }
        floatingTextField.placeholder = placeholder
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
