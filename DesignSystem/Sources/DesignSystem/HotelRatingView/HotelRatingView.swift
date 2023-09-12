//
//  HotelRatingView.swift
//  
//
//  Created by Dinmukhamed on 11.09.2023.
//

import UIKit
import SnapKit

public class HotelRatingView: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "★ 5 Превосходно"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = Color.ratingOrange
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
        backgroundColor = Color.ratingBackgroundOrange
        layer.cornerRadius = 5
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [titleLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }

}
