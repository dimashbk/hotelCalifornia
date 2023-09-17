//
//  TourPriceView.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 17.09.2023.
//

import UIKit

final class TourPriceView: UIView {

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
        backgroundColor = .white
        layer.cornerRadius = 12
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(70)
        }
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

