//
//  TourPriceView.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 17.09.2023.
//

import UIKit

final class TourPriceView: UIView {
    
    private var tourView = TourPriceAdditionalView()
    private var fuelFeeView = TourPriceAdditionalView()
    private var serviceFeeView = TourPriceAdditionalView()
    private var totalPriceView = TourPriceAdditionalView()

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
        [tourView, fuelFeeView, serviceFeeView,
         totalPriceView].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        tourView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.right.equalToSuperview()
        }
        fuelFeeView.snp.makeConstraints { make in
            make.top.equalTo(tourView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        serviceFeeView.snp.makeConstraints { make in
            make.top.equalTo(fuelFeeView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        totalPriceView.snp.makeConstraints { make in
            make.top.equalTo(serviceFeeView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    public func configure(configuration: PaymentModel) {
        tourView.configure(infoName: "Тур", info: String(configuration.tourPrice) + " ₽")
        fuelFeeView.configure(infoName: "Топливный сбор", info: String(configuration.fuelCharge) + " ₽")
        serviceFeeView.configure(infoName: "Сервисный сбор", info: String(configuration.serviceCharge) + " ₽")
        totalPriceView.configure(infoName: "К оплате", info: String(configuration.tourPrice +
                                                            configuration.fuelCharge +
                                                            configuration.serviceCharge) + " ₽")
    }
}

final class TourPriceAdditionalView: UIView {
    
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
            make.left.equalToSuperview().inset(16)
        }
        infoLabel.snp.makeConstraints { make in
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

