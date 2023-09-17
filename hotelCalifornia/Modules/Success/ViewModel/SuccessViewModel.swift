//
//  SuccessViewModel.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 17.09.2023.
//

import Foundation

final class SuccessViewModel {
    
    var coordinatorDelegate: SuccessCoordinatorProtocol?
    
    func navigateToRootView() {
        coordinatorDelegate?.showRootFlow()
    }
}
