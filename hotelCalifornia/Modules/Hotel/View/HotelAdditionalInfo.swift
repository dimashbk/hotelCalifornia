//
//  HotelAdditionalInfo.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 11.09.2023.
//

import UIKit
import SnapKit
import TTGTags

final class HotelAdditionalInfo: UIView , TTGTextTagCollectionViewDelegate{

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Об отеле"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    let tagView = TTGTextTagCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        let textTag = TTGTextTag(content: TTGTextTagStringContent(text: "tutuge"), style: TTGTextTagStyle())
        let textTag2 = TTGTextTag(content: TTGTextTagStringContent(text: "tutuge"), style: TTGTextTagStyle())
        let textTag3 = TTGTextTag(content: TTGTextTagStringContent(text: "tutuge"), style: TTGTextTagStyle())
        let textTag4 = TTGTextTag(content: TTGTextTagStringContent(text: "tutuge"), style: TTGTextTagStyle())
        tagView.addTag(textTag)
        tagView.addTag(textTag2)
        tagView.addTag(textTag3)
        tagView.addTag(textTag4)
        tagView.reload()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tagView.delegate = self
        backgroundColor = .white
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
            make.height.equalTo(80)
        }
    }
}
