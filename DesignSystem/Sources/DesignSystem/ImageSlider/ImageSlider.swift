//
//  ImageSlider.swift
//  
//
//  Created by Dinmukhamed on 14.09.2023.
//

import UIKit

public class ImageSlider: UIView {
    
    var currentCellIndex = 0
    var images = [String]()
    
    private var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.backgroundColor = .cyan
        collectionView.isScrollEnabled = false
        collectionView.layer.cornerRadius = 15
        return collectionView
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .white
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.layer.cornerRadius = 5
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        setupSubviews()
        setupConstraints()
        setupSwipeGestures()
    }
    
    private func setupSubviews() {
        [imagesCollectionView, pageControl].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        imagesCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupSwipeGestures() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToRight))
        rightSwipe.direction = .right
        addGestureRecognizer(rightSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToLeft))
        leftSwipe.direction = .left
        addGestureRecognizer(leftSwipe)
    }
    
    public func configure(images: [String]?) {
        guard let images = images else { return }
        DispatchQueue.main.async {
            self.images = images
            self.pageControl.numberOfPages = images.count
            self.imagesCollectionView.reloadData()
        }
    }

    @objc
    func swipeToRight() {
        guard currentCellIndex > 0 else { return }
        currentCellIndex -= 1
        imagesCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .left, animated: true)
        pageControl.currentPage = currentCellIndex
    }
    
    @objc
    func swipeToLeft() {
        guard currentCellIndex != images.count - 1 else { return }
        currentCellIndex += 1
        imagesCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        pageControl.currentPage = currentCellIndex
    }
}

extension ImageSlider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(image: images[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imagesCollectionView.frame.width, height: imagesCollectionView.frame.height)
    }
}
