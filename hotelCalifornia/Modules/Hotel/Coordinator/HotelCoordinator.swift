//
//  HotelCoordinator.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import Foundation


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
        let profileVC = HotelViewController()
        profileVC.viewModel = viewModel
        profileVC.viewModel?.coordinatorDelegate = self
        navigationController.pushViewController(profileVC, animated: true)
    }
}

extension HotelCoordinator: HotelCoordinatorProtocol {
    func showNumberFlow() {
        print("number")
    }
}
