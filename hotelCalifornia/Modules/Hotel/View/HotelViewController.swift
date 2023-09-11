//
//  HotelViewController.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 08.09.2023.
//

import UIKit

final class HotelViewController: UIViewController {
    
    let mainInfo = HotelMainInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .red
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [mainInfo].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        mainInfo.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}


