//
//  HotelViewController.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 08.09.2023.
//

import UIKit
import DesignSystem

final class HotelViewController: UIViewController {
    
    let mainInfo = HotelMainInfo()
    let additionalInfo = HotelAdditionalInfo()
    
    lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(mainInfo)
        view.addArrangedSubview(additionalInfo)
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    lazy var scrollView = DynamicHeightScrollView( contentView: contentView )

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = Color.ratingBackgroundOrange
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [scrollView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


