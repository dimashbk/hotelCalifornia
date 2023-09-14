//
//  AppDelegate.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 08.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinate: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - Window setup
        window = UIWindow(frame: UIScreen.main.bounds)
        setCoordinator()
        
        return true
    }
    
    private func setCoordinator() {
        appCoordinate = AppCoordinator(window: window!)
        appCoordinate?.start()
    }

}

