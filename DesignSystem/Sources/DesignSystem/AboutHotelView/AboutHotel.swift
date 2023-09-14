//
//  AboutHotelView.swift
//  
//
//  Created by Dinmukhamed on 14.09.2023.
//

import UIKit

public class AboutHotelView: UIView {
    
    private var titlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = Color.mainBlue
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "rightArrow")?.withTintColor(Color.mainBlue)
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = Color.mainBlue.withAlphaComponent(0.1)
        layer.cornerRadius = 8
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [titlLabel, imageView].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        titlLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(24)
        }
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(8)
        }
    }
    
    public func configure(titleText: String) {
        self.titlLabel.text = titleText
    }
}
