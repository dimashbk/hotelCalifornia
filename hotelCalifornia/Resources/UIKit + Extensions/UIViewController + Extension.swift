//
//  UIViewController + Extension.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 08.09.2023.
//

import Foundation


import UIKit
import SwiftUI

extension UIViewController {
    // enable preview for UIKit
    // source: https://fluffy.es/xcode-previews-uikit/
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        Preview(viewController: self)
    }
}

extension UIViewController {
    /// Adds childViewController to the root view of the UIViewController.
    @objc
    func addContainer(childViewController: UIViewController) {
        addContainer(childViewController: childViewController, on: view)
    }
    
    /// Adds childViewController to the specified view.
    ///
    /// - Parameters:
    ///   - childViewController: Child View Controller to be added.
    ///   - view: Target view to which chilViewController's root view will be added as a subview.
    @objc
    func addContainer(childViewController: UIViewController, on view: UIView) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        childViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        childViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        childViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        childViewController.didMove(toParent: self)
    }
    
    func removeContainer() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    

    @objc
    func removeChildViewControllers() {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}
