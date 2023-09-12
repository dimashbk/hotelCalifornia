//
//  TagCollectionViewCell.swift
//  
//
//  Created by Dinmukhamed on 12.09.2023.
//

import UIKit

final public class TagCollectionViewCell: UICollectionViewCell {

    public static var className: String {
        String(describing: TagCollectionViewCell.self)
    }

    private let nameLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        nameLabel.font = .systemFont(ofSize: 12, weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layer.cornerRadius = 5
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            nameLabel.heightAnchor.constraint(equalToConstant: 29),
        ])
    }

    required init?(coder: NSCoder) {
        nil
    }

    public func configure(name: String) {
        contentView.backgroundColor = isSelected ? Color.tagBackgroundGray: Color.tagBackgroundGray
        nameLabel.textColor = isSelected ?  Color.tagBackgroundText : Color.tagBackgroundText
        nameLabel.text = name
    }

    public override var isSelected: Bool {
        didSet {
            nameLabel.textColor = isSelected ? Color.tagBackgroundText : Color.tagBackgroundText
            contentView.backgroundColor = isSelected ? Color.tagBackgroundGray : Color.tagBackgroundGray
        }
    }
}
