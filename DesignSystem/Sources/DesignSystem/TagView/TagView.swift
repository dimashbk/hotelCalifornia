//
//  File.swift
//  
//
//  Created by Dinmukhamed on 11.09.2023.
//


import UIKit

final public class TagCollectionView: UICollectionView {

    public init() {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        super.init(frame: .zero, collectionViewLayout: layout)

        allowsMultipleSelection = true

        register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.className)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize){
             self.invalidateIntrinsicContentSize()
           }
    }
    
    public override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

final class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) else { return nil }
        var currentRowY: CGFloat = -1.0
        var currentRowX: CGFloat = 0
        for attribute in attributes where attribute.representedElementCategory == .cell {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                currentRowX = sectionInset.left
            }
            attribute.frame.origin.x = currentRowX
            currentRowX += attribute.frame.width + minimumInteritemSpacing
        }
        return attributes
    }
}
