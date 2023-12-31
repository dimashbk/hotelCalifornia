//
//  PaymentViewController.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 16.09.2023.
//

import UIKit
import DesignSystem

final class PaymentViewController: UIViewController {
    
    var viewModel: PaymentViewModelProtocol?
    private var generalView = GeneralInfoView()
    private var detailView = DetailInfoView()
    private var buyerInfoView = BuyerInfoView()
    private var firstTourist = TouristInfoView()
    private var secondTourist = TouristInfoView()
    private var tourPriceView = TourPriceView()
    private var buttonView = HotelButtonView()
    private lazy var scrollView = DynamicHeightScrollView(contentView: contentView)
    
    private lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.getPaymentInfo()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        setupScrollView()
        setupButton()
        bindViewModel()
    }
    
    private func setupSubviews() {
        [scrollView].forEach {
            view.addSubview($0)
        }
        [generalView, detailView, buyerInfoView,
         firstTourist, secondTourist, tourPriceView, buttonView].forEach {
            contentView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.right.left.equalToSuperview()
        }
    }
    
    private func setupScrollView() {
        scrollView.backgroundColor = .secondarySystemBackground
    }
    
    private func bindViewModel() {
        viewModel?.updateViewData = { [weak self] in
            guard let configuration = self?.viewModel?.paymentModel else { return }
            self?.detailView.configure(configuration: configuration)
            self?.tourPriceView.configure(configuration: configuration)
        }
    }
    
    private func setupButton() {
        buttonView.button.setTitle("Оплатить")
        buttonView.button.onTap = { [weak self] in
            self?.viewModel?.navigateToSuccess()
        }
    }
}
