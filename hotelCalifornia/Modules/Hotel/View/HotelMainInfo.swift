//
//  HotelMainInfo.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 08.09.2023.
//

import UIKit
import SnapKit
import DesignSystem

final class HotelMainInfo: UIView {
    
    private var imageSlider = ImageSlider()
    private var ratingView = HotelRatingView()
    
    private var hotelName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private var hotelAddress: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Color.mainBlue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var hotelPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    private var priceForIt: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.backgroundColor = .white
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
        [imageSlider, ratingView, hotelName,
         hotelAddress, hotelPrice, priceForIt].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        imageSlider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(257)
        }
        ratingView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(imageSlider.snp.bottom).offset(16)
        }
        hotelName.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(ratingView.snp.bottom).offset(8)
        }
        hotelAddress.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(hotelName.snp.bottom).offset(8)
        }
        hotelPrice.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(hotelAddress.snp.bottom).offset(16)
        }
        priceForIt.snp.makeConstraints { make in
            make.left.equalTo(hotelPrice.snp.right).offset(8)
            make.bottom.equalTo(hotelPrice).inset(4)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    public func configure(configuration: HotelModel) {
        DispatchQueue.main.async {
            self.imageSlider.configure(images: configuration.imageUrls)
            self.hotelName.text = configuration.name
            self.hotelAddress.text = configuration.adress
            self.hotelPrice.text = "от \(configuration.minimalPrice) ₽"
            self.priceForIt.text = configuration.priceForIt
        }
    }
}


