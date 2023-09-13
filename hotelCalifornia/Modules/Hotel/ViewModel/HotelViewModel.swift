//
//  HotelViewModel.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import Foundation
import UIKit

final class HotelViewModel {
    
    var hotelInfo: HotelModel?
    var updateViewData: (() -> ())?
    
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
    
    func getImages() -> [UIImage] {
        var images = [UIImage]()
        
        for i in hotelInfo!.imageUrls {
            let url = URL(string: i)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check /
                    images.append(UIImage(data: data!)!)
        }
        return images
    }
}
