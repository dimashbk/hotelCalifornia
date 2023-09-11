//
//  ImageCollectionViewCell.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 08.09.2023.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    private var hotelImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .brown
        return image
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
        contentView.addSubview(hotelImageView)
    }
    
    private func setupConstraints() {
        hotelImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
