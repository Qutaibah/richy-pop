//
//  UIImageView+ImageManager.swift
//  Richy
//
//  Created by Qutaibah Essa on 01/06/2020.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(source: RichAlertController.ImageSource?) {
        switch source {
        case .image(let image):
            self.image = image
        case .url(let url):
            if let image = UIImage(named: url) {
                return self.image = image
            }
            let contentMode = self.contentMode
            kf.setImage(with: URL(string: url)) { [weak self] (image, error, cache, url) in
                self?.contentMode = contentMode
            }
        case .none:
            break
        }
    }
}
