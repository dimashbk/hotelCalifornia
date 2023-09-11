//
//  DynamicScrollView.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 08.09.2023.
//

import UIKit

open class DynamicScrollView: UIScrollView {
  
  var contentView: UIView?
  
  init() {
    self.contentView = nil
    super.init(frame: .zero)
  }

  init(contentView: UIView, padding: UIEdgeInsets = .zero) {
    self.contentView = contentView
    super.init(frame: .zero)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    configureContentView(padding)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureContentView(_ inset: UIEdgeInsets) {
    guard let contentView = contentView else { return }
    self.addSubview(contentView)
    
    contentView.widthAnchor.constraint(
      equalTo: self.widthAnchor,
      multiplier: 1,
      constant: -(inset.left + inset.right)
    ).isActive = true
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(
        equalTo: contentLayoutGuide.topAnchor,
        constant: inset.top
      ),
      contentView.leadingAnchor.constraint(
        equalTo: contentLayoutGuide.leadingAnchor,
        constant: inset.left
      ),
      contentView.trailingAnchor.constraint(
        equalTo: contentLayoutGuide.trailingAnchor,
        constant: -inset.right
      ),
      contentView.bottomAnchor.constraint(
        equalTo: contentLayoutGuide.bottomAnchor,
        constant: -inset.bottom
      )
    ])
    
  }
}

