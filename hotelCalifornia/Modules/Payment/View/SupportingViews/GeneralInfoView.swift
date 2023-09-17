//
//  GeneralInfoView.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 16.09.2023.
//

import UIKit
import DesignSystem

final class GeneralInfoView: UIView {
    
    private var ratingView = HotelRatingView()
    
    private var hotelName: UILabel = {
        let label = UILabel()
        label.text = "Steigenberger Makadi"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private var hotelAddress: UILabel = {
        let label = UILabel()
        label.text = "Madinat Makadi, Safaga Road, Makadi Bay, Египет"
        label.numberOfLines = 0
        label.textColor = Color.mainBlue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12
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
        [ratingView, hotelName, hotelAddress].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        ratingView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(16)
        }
        hotelName.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(ratingView.snp.bottom).offset(8)
        }
        hotelAddress.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(16)
            make.top.equalTo(hotelName.snp.bottom).offset(8)
        }
    }
}
