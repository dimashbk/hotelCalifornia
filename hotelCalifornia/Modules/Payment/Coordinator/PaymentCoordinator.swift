//
//  PaymentCoordinator.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 16.09.2023.
//

import UIKit

protocol SuccessFlow {
    func showSuccessFlow()
}

typealias PaymentCoordinatorProtocol = SuccessFlow

final class PaymentCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewModel = PaymentViewModel()
        let paymentVC = PaymentViewController()
        paymentVC.viewModel = viewModel
        paymentVC.viewModel?.coordinatorDelegate = self
        navigationController.pushViewController(paymentVC, animated: true)
    }
}

extension PaymentCoordinator: PaymentCoordinatorProtocol {
    func showSuccessFlow() {
        let successCoordinator = SuccessCoordinator(navigationController: navigationController)
        coordinate(to: successCoordinator)
    }
}
