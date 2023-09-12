//
//  HotelMainInfo.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 08.09.2023.
//

import UIKit
import SnapKit
import DesignSystem

final class HotelMainInfo: UIView {
    
    private var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.backgroundColor = .cyan
        collectionView.layer.cornerRadius = 15
        return collectionView
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 10
        pageControl.backgroundColor = .white
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.layer.cornerRadius = 5
        return pageControl
    }()
    
    private var ratingView = HotelRatingView()
    
    private var hotelName: UILabel = {
        let label = UILabel()
        label.text = "Steigenberger Makadi"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private var hotelAddress: UILabel = {
        let label = UILabel()
        label.text = "Madinat Makadi, Safaga Road, Makadi Bay, Египет"
        label.textColor = Color.mainBlue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private var hotelPrice: UILabel = {
        let label = UILabel()
        label.text = "от 134 673 ₽"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.backgroundColor = .white
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
        [imagesCollectionView, ratingView, hotelName,
         hotelAddress, hotelPrice].forEach {
            addSubview($0)
        }
        imagesCollectionView.addSubview(pageControl)
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(432)
        }
        imagesCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(257)
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(-232)
            make.left.right.equalToSuperview().inset(100)
        }
        ratingView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(imagesCollectionView.snp.bottom).offset(16)
        }
        hotelName.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(ratingView.snp.bottom).offset(8)
        }
        hotelAddress.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(hotelName.snp.bottom).offset(8)
        }
        hotelPrice.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(hotelAddress.snp.bottom).offset(16)
        }
    }
}

extension HotelMainInfo: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imagesCollectionView.frame.width, height: imagesCollectionView.frame.height)
    }
}
