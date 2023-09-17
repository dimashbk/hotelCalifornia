//
//  HotelViewModel.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import Foundation
import UIKit

protocol HotelNetworking {
    func getHotelInfo()
    var updateViewData: (() -> ())? { get set }
    var hotelInfo: HotelModel? { get set }
}

protocol HotelNavigation {
    func navigateToNumbersFlow()
    var coordinatorDelegate: HotelCoordinatorProtocol? { get set }
}

typealias HotelViewModelProtocol = HotelNetworking & HotelNavigation

final class HotelViewModel: HotelViewModelProtocol {
    
    var hotelInfo: HotelModel?
    var updateViewData: (() -> ())?
    var coordinatorDelegate: HotelCoordinatorProtocol?
    
    func getHotelInfo() {
        guard let url = URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3") else { return }
        
        NetworkService.shared.fetchData(url: url) { (result: Result<HotelModel, Error>) in
            switch result {
            case .success(let info):
                self.hotelInfo = info
                self.updateViewData?()
            case .failure(let error):
                print("not that good 667: \(error.localizedDescription)")
            }
        }
    }
    
    func navigateToNumbersFlow() {
        coordinatorDelegate?.showNumberFlow()
    }
}
