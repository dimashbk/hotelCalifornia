//
//  BuyerInfoView.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 17.09.2023.
//

import UIKit
import DesignSystem

final class BuyerInfoView: UIView {
    
    private var numberTextField: DSTextField = {
        let textField = DSTextField()
        textField.configure(inputConfiguration: .init(placeholder: "Phone"))
        textField.setPhoneNumberMask()
        return textField
    }()
    
    private var emailTextField: DSTextField = {
        let textField = DSTextField()
        textField.configure(inputConfiguration: .init(placeholder: "E-mail"))
        return textField
    }()

    private var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 12
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [numberTextField, emailTextField, captionLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        numberTextField.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(16)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        captionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
        }
    }
}
