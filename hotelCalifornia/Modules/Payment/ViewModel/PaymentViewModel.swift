//
//  PaymentViewModel.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 16.09.2023.
//

import Foundation

protocol PaymentNetworking {
    func getPaymentInfo()
    var updateViewData: (() -> ())? { get set }
    var paymentModel: PaymentModel? { get set }
}

protocol PaymentNavigation {
    func navigateToSuccess()
    var coordinatorDelegate: PaymentCoordinator? { get set }
}

typealias PaymentViewModelProtocol = PaymentNetworking & PaymentNavigation

final class PaymentViewModel: PaymentViewModelProtocol {
    
    var updateViewData: (() -> ())?
    var paymentModel: PaymentModel?
    var coordinatorDelegate: PaymentCoordinator?

    func getPaymentInfo() {
        guard let url = URL(string: "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8") else { return }
        
        NetworkService.shared.fetchData(url: url) { [self] (result: Result<PaymentModel, Error>) in
            switch result {
            case .success(let info):
                self.paymentModel = info
                self.updateViewData?()
            case .failure(let error):
                print("not that good 667: \(error.localizedDescription)")
            }
        }
    }
    
    func navigateToSuccess() {
        coordinatorDelegate?.showSuccessFlow()
    }
}
