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
    private let mainInfo = HotelMainInfo()
    private let additionalInfo = HotelAdditionalInfo()
    private let buttonView = HotelButtonView()
    private lazy var scrollView = DynamicHeightScrollView(contentView: contentView)
    
    private lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(mainInfo)
        view.addArrangedSubview(additionalInfo)
        view.addArrangedSubview(buttonView)
        view.axis = .vertical
        view.spacing = 8
        return view
    }()

    override func loadView() {
        super.loadView()
        viewModel?.getHotelInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .secondarySystemBackground
        setupSubviews()
        setupConstraints()
        setupButton()
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
    
    private func setupButton() {
        buttonView.button.addTarget(self, action: #selector(moveToNumbers), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel?.updateViewData = {
            guard let hotelInfo = self.viewModel?.hotelInfo else { return }
            self.mainInfo.configure(configuration: hotelInfo)
            self.additionalInfo.configure(configuration: hotelInfo)
        }
    }
    
    @objc func moveToNumbers() {
        viewModel?.navigateToNumbersFlow()
    }
}


