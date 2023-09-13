//
//  AboutHotelTableViewCell.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 13.09.2023.
//

import UIKit
import DesignSystem

final class AboutHotelTableViewCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var settingNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var navigationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "rightArrow")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure func
    public func configure(type: AboutHotelSettingsRow) {
        settingNameLabel.text = type.rowType.rawValue
        leftImageView.image = type.leftImage
        setupRightArrow()
    }
    
    //MARK: - setup funcs
    private func setup() {
        self.backgroundColor = Color.tagBackgroundGray
        setupSubview()
        setupConstraints()
    }
    
    private func setupSubview() {
        [leftImageView, settingNameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        settingNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(leftImageView.snp.right).offset(12)
        }
    }

    
    private func setupRightArrow() {
        contentView.addSubview(navigationImageView)
        navigationImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }

}
