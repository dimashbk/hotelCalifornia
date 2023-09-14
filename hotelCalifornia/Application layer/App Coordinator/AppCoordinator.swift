//
//  AppCoordinator.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        let hotelViewCoordinator = HotelCoordinator(navigationController: navigationController)
        coordinate(to: hotelViewCoordinator)
    }
}
