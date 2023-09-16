//
//  DetailInfoView.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 16.09.2023.
//

import UIKit
import DesignSystem

final class DetailInfoView: UIView {
    
    var departureView = DetailPaymentInfoAdditionalView()
    var locationView  = DetailPaymentInfoAdditionalView()
    var dateView      = DetailPaymentInfoAdditionalView()
    var daysView      = DetailPaymentInfoAdditionalView()
    var hotelView     = DetailPaymentInfoAdditionalView()
    var numberView    = DetailPaymentInfoAdditionalView()
    var mealView      = DetailPaymentInfoAdditionalView()
    
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
        [departureView, locationView, dateView,
         daysView, hotelView, numberView,
         mealView].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        departureView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.right.equalToSuperview()
        }
        locationView.snp.makeConstraints { make in
            make.top.equalTo(departureView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        dateView.snp.makeConstraints { make in
            make.top.equalTo(locationView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        daysView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        hotelView.snp.makeConstraints { make in
            make.top.equalTo(daysView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        numberView.snp.makeConstraints { make in
            make.top.equalTo(hotelView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        mealView.snp.makeConstraints { make in
            make.top.equalTo(numberView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    public func configure(configuration: PaymentModel) {
        departureView.configure(infoName: "Вылет из", info: configuration.departure)
        locationView.configure(infoName: "Страна, город", info: configuration.arrivalCountry)
        dateView.configure(infoName: "Даты", info: "\(configuration.tourDateStart) - \(configuration.tourDateStop)")
        daysView.configure(infoName: "Кол-во дней", info: String(configuration.numberOfNights))
        hotelView.configure(infoName: "Отель", info: configuration.hotelName)
        numberView.configure(infoName: "Номер", info: configuration.room)
        mealView.configure(infoName: "Питание", info: configuration.nutrition)
    }
}

final class DetailPaymentInfoAdditionalView: UIView {
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "jddjdjdddd"
        label.textColor = .lightGray
        return label
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "dhdhddmvkdmhdhd"
        label.numberOfLines = 0
        label.textColor = .black
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
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [nameLabel, infoLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.width.equalTo(120)
            make.left.equalToSuperview().inset(16)
        }
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.top.bottom.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    public func configure(infoName: String, info: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = infoName
            self.infoLabel.text = info
        }
    }
}
