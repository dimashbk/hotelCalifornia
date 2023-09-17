//
//  TouristInfoView.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 17.09.2023.
//

import UIKit
import DesignSystem

final class TouristInfoView: UIView {
    
    private var touristLabel: UILabel = {
        let label = UILabel()
        label.text = "Первый турист"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "up"), for: .selected)
        button.setImage(.init(named: "down"), for: .normal)
        button.addTarget(self, action: #selector(changeButtonState), for: .touchUpInside)
        return button
    }()
    
    private var nameTextField: DSTextField = {
        let textField = DSTextField()
        textField.configure(inputConfiguration: .init(placeholder: "Имя"))
        textField.setPhoneNumberMask()
        return textField
    }()
    
    private var surnameTextField: DSTextField = {
        let textField = DSTextField()
        textField.configure(inputConfiguration: .init(placeholder: "Фамилия"))
        textField.setPhoneNumberMask()
        return textField
    }()

    private var dateOfBirthTextField: DSTextField = {
        let textField = DSTextField()
        textField.configure(inputConfiguration: .init(placeholder: "Дата рождения"))
        textField.setPhoneNumberMask()
        return textField
    }()
    
    
    private var citizenshipTextField: DSTextField = {
        let textField = DSTextField()
        textField.configure(inputConfiguration: .init(placeholder: "Гражданство"))
        textField.setPhoneNumberMask()
        return textField
    }()
    
    private var passportNumberTextField: DSTextField = {
        let textField = DSTextField()
        textField.configure(inputConfiguration: .init(placeholder: "Номер паспорта"))
        textField.setPhoneNumberMask()
        return textField
    }()
    
    private var passportDeadlineTextField: DSTextField = {
        let textField = DSTextField()
        textField.configure(inputConfiguration: .init(placeholder: "Срок окончания паспорта"))
        textField.setPhoneNumberMask()
        return textField
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
        [touristLabel, button, nameTextField,
         surnameTextField, dateOfBirthTextField, citizenshipTextField,
         passportNumberTextField, passportDeadlineTextField].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        touristLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(16)
        }
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(13)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(touristLabel.snp.bottom).offset(16)
            make.right.left.equalToSuperview().inset(16)
        }
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.right.left.equalToSuperview().inset(16)
        }
        dateOfBirthTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(8)
            make.right.left.equalToSuperview().inset(16)
        }
        citizenshipTextField.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirthTextField.snp.bottom).offset(8)
            make.right.left.equalToSuperview().inset(16)
        }
        passportNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(citizenshipTextField.snp.bottom).offset(8)
            make.right.left.equalToSuperview().inset(16)
        }
        passportDeadlineTextField.snp.makeConstraints { make in
            make.top.equalTo(passportNumberTextField.snp.bottom).offset(8)
            make.right.left.equalToSuperview().inset(16)
        }
        snp.makeConstraints { make in
            make.height.equalTo(58)
        }
    }
    
    @objc func changeButtonState() {
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            UIView.animate(withDuration: 0.3) {
                self.snp.updateConstraints { make in
                    make.height.equalTo(470)
                }
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.snp.updateConstraints { make in
                    make.height.equalTo(58)
                }
            }
        }
        self.layoutIfNeeded()
    }
}
