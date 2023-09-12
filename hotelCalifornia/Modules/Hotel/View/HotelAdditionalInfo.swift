//
//  HotelAdditionalInfo.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 11.09.2023.
//

import UIKit
import SnapKit
import DesignSystem

final class HotelAdditionalInfo: UIView {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Об отеле"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
     
    var tags = ["Бесплатный Wifi на всей территории отеля",
                "1 км до пляжа",
                "Бесплатный фитнес-клуб",
                "20 км до аэропорта"]
    
    private let tagView: TagCollectionView = TagCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        tagView.dataSource = self
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [titleLabel, tagView].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(428)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(16)
        }
        tagView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HotelAdditionalInfo: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.className, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(name: tags[indexPath.row])
        return cell
    }
}
