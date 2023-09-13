//
//  AboutHotelModel.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 13.09.2023.
//

import UIKit

struct AboutHotelSettingsRow {
    var rowType: AboutHotelRowType
    var leftImage: UIImage?
}

enum AboutHotelRowType: String {
    case convinience = "Удобства"
    case whatIncluded = "Что включено"
    case whatNotIncluded = "Что не включено"
}
