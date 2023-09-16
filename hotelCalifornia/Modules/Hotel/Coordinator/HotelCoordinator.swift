//
//  HotelCoordinator.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import UIKit

protocol NumberFlow {
    func showNumberFlow()
}

typealias HotelCoordinatorProtocol = NumberFlow

final class HotelCoordinator: BaseCoordinator{

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewModel = HotelViewModel()
        let hotelVC = HotelViewController()
        hotelVC.viewModel = viewModel
        hotelVC.viewModel?.coordinatorDelegate = self
        navigationController.pushViewController(hotelVC, animated: true)
    }
}

extension HotelCoordinator: HotelCoordinatorProtocol {
    func showNumberFlow() {
        let numbersCoordinator = NumbersCoordinator(navigationController: navigationController)
        coordinate(to: numbersCoordinator)
    }
}
