//
//  File.swift
//  
//
//  Created by Dinmukhamed on 14.09.2023.
//

import UIKit
import Kingfisher

extension UIImageView{
    // MARK: - Set Images func
    func setImage(imageUrl: String){
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
