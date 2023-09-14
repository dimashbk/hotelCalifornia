//
//  HotelViewController.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 08.09.2023.
//

import UIKit
import DesignSystem

final class HotelViewController: UIViewController {
    
    var viewModel: HotelViewModel?
    let mainInfo = HotelMainInfo()
    let additionalInfo = HotelAdditionalInfo()
    let buttonView = HotelButtonView()
    lazy var scrollView = DynamicHeightScrollView(contentView: contentView)
    
    lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(mainInfo)
        view.addArrangedSubview(additionalInfo)
        view.addArrangedSubview(buttonView)
        view.axis = .vertical
        view.spacing = 8
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.getHotelInfo()
    }
    
    private func setup() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .secondarySystemBackground
        setupSubviews()
        setupConstraints()
        bindViewModel()
    }
    
    private func setupSubviews() {
        [scrollView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel?.updateViewData = {
            guard let hotelInfo = self.viewModel?.hotelInfo else { return }
            self.mainInfo.configure(configuration: hotelInfo)
            self.additionalInfo.configure(configuration: hotelInfo)
        }
    }
}


