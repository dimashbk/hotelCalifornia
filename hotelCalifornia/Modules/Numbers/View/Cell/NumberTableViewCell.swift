//
//  NumberTableViewCell.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import UIKit
import DesignSystem

final class NumberTableViewCell: UITableViewCell {
    
    var tags = [String]()
    var onTap: (() -> ())?
    private var imageSlider = ImageSlider()
    private var tagView = TagCollectionView()
    private var aboutHotel = AboutHotelView()
    
    var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private var priceLabel: UILabel = {
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
    
    public var button = DSButton(height: .M,
                                  colorType: .primary,
                                  titleText: "К выбору номера")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tagView.dataSource = self
        contentView.backgroundColor = .secondarySystemBackground
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        aboutHotel.configure(titleText: "Подробнее о номере")
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubview(containerView)
        [imageSlider, tagView, typeLabel,
         aboutHotel, priceLabel, priceForIt,
         button].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        imageSlider.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(257)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(imageSlider.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        tagView.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        aboutHotel.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(16)
        }
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(aboutHotel.snp.bottom).offset(16)
        }
        priceForIt.snp.makeConstraints { make in
            make.left.equalTo(priceLabel.snp.right).offset(8)
            make.bottom.equalTo(priceLabel).inset(4)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    public func configure(configuration: Room) {
        DispatchQueue.main.async {
            self.imageSlider.configure(images: configuration.imageUrls)
            self.tags = configuration.peculiarities
            self.tagView.reloadData()
            self.typeLabel.text = configuration.name
            self.priceLabel.text = "от \(configuration.price) ₽"
            self.priceForIt.text = configuration.pricePer
        }
    }
    
    @objc func buttonTapped() {
        onTap?()
    }
}

// MARK: - UICollectionViewDataSource
extension NumberTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.className, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(name: tags[indexPath.row])
        return cell
    }
}
