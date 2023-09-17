//
//  SuccessViewController.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 17.09.2023.
//

import UIKit

final class SuccessViewController: UIViewController {
    
    var viewModel: SuccessViewModel?
    private var buttonView = HotelButtonView()
    
    private var successImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "congrats")
        return  imageView
    }()
    
    private var firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш заказ принят в работу"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private var secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .white
        title = "Заказ оплачен"
        setupSubviews()
        setupConstraints()
        setupButton()
    }
    
    private func setupSubviews() {
        [successImageView, firstLabel, secondLabel,
         buttonView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        successImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(127)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        firstLabel.snp.makeConstraints { make in
            make.top.equalTo(successImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
        }
        buttonView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupButton() {
        buttonView.button.setTitle("Супер!")
        buttonView.button.onTap = { [weak self] in
            self?.viewModel?.navigateToRootView()
        }
    }
}
