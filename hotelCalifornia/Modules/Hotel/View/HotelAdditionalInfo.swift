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
    
    var aboutHotelSettings: [AboutHotelSettingsRow] = [
        .init(rowType: .convinience, leftImage: .init(named: "convinience")),
        .init(rowType: .whatIncluded, leftImage: .init(named: "included")),
        .init(rowType: .whatNotIncluded, leftImage: .init(named: "notIncluded"))]

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Об отеле"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!"
        label.numberOfLines = 0
        return label
    }()
    
    private var aboutHotelTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.register(AboutHotelTableViewCell.self, forCellReuseIdentifier: "AboutHotelTableViewCell")
        return tableView
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
        layer.cornerRadius = 12
        aboutHotelTableView.delegate = self
        aboutHotelTableView.dataSource = self
        backgroundColor = .white
        tagView.dataSource = self
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [titleLabel, tagView, infoLabel, aboutHotelTableView].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(16)
        }
        tagView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        aboutHotelTableView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview().inset(16)
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


extension HotelAdditionalInfo: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aboutHotelSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AboutHotelTableViewCell", for: indexPath) as? AboutHotelTableViewCell else { return UITableViewCell() }
        cell.configure(type: aboutHotelSettings[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
}

