//
//  NumbersCoordinator.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import Foundation
import UIKit

protocol PaymentFlow {
    func showPaymentFlow()
}

typealias NumbersCoordinatorProtocol = PaymentFlow

final class NumbersCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewModel = NumbersViewModel()
        let numbersVC = NumbersViewController()
        numbersVC.viewModel = viewModel
        numbersVC.viewModel?.coordinatorDelegate = self
        navigationController.pushViewController(numbersVC, animated: true)
    }
}

extension NumbersCoordinator: NumbersCoordinatorProtocol {
    func showPaymentFlow() {
        print("Payments")
    }
}
