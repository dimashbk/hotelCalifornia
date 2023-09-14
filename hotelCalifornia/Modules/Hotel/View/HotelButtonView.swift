//
//  HotelButtonView.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 13.09.2023.
//

import UIKit
import DesignSystem

final class HotelButtonView: UIView {
    
    public var button = DSButton(height: .M,
                                  colorType: .primary,
                                  titleText: "К выбору номера")
    
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
        addSubview(button)
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
        }
        snp.makeConstraints { make in
            make.height.equalTo(70)
        }
    }

}
