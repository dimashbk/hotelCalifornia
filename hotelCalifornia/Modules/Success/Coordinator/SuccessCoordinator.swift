//
//  SuccessCoordinator.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 17.09.2023.
//

import Foundation

import UIKit

protocol RootFlow {
    func showRootFlow()
}

typealias SuccessCoordinatorProtocol = RootFlow

final class SuccessCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewModel = SuccessViewModel()
        let successVC = SuccessViewController()
        successVC.viewModel = viewModel
        successVC.viewModel?.coordinatorDelegate = self
        navigationController.pushViewController(successVC, animated: true)
    }
}

extension SuccessCoordinator: SuccessCoordinatorProtocol {
    func showRootFlow() {
        self.navigationController.popToRootViewController(animated: true)
    }
}
