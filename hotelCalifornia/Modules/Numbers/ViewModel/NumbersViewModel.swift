//
//  NumbersViewModel.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import Foundation

protocol NumbersNetworking {
    func getNumbers()
    var updateViewData: (() -> ())? { get set }
    var rooms: [Room] { get set }
}

protocol NumbersNavigation {
    func navigateToPaymentFlow()
    var coordinatorDelegate: NumbersCoordinatorProtocol? { get set }
}

typealias NumbersViewModelProtocol = NumbersNetworking & NumbersNavigation

final class NumbersViewModel: NumbersViewModelProtocol{
    
    var rooms = [Room]()
    var updateViewData: (() -> ())?
    var coordinatorDelegate: NumbersCoordinatorProtocol?
    
    func getNumbers() {
        guard let url = URL(string: "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd") else { return }
        
        NetworkService.shared.fetchData(url: url) { (result: Result<NumbersModel, Error>) in
            switch result {
            case .success(let numbers):
                self.rooms = numbers.rooms
                self.updateViewData?()
            case .failure(let error):
                print("not that good 667: \(error.localizedDescription)")
            }
        }
    }
    
    func navigateToPaymentFlow() {
        coordinatorDelegate?.showPaymentFlow()
    }
    
}
