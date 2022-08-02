//
//  ImageView.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

class ImageView: BaseView {
    
    private lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "swift-1")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    init(source: RichAlertController.ImageSource) {
        super.init(frame: .zero)
        imageView.setImage(source: source)
        contentHeight = 120
        contentView = imageView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
