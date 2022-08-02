//
//  IconView.swift
//  Richy
//
//  Created by Qutaibah Essa on 19/04/2020.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit

class IconView: BaseView {
        
    var iconHeight: CGFloat = 64

    private lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    init(source: RichAlertController.ImageSource) {
        super.init(frame: .zero)
        iconImage.setImage(source: source)
        contentHeight = 64
        contentView = iconImage
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
