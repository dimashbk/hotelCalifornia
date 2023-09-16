//
//  PaymentViewModel.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 16.09.2023.
//

import Foundation

final class PaymentViewModel {
    
    var coordinatorDelegate: PaymentCoordinator?
    var updateViewData: (() -> ())?
    var paymentModel: PaymentModel?

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
}
