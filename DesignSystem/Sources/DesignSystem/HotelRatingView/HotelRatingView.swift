//
//  HotelRatingView.swift
//  
//
//  Created by Dinmukhamed on 11.09.2023.
//

import UIKit

public class HotelRatingView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .yellow
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }

}
