//
//  RichLabel.swift
//  Richy
//
//  Created by Qutaibah Essa on 12/07/2020.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit

public class RichLabel: BaseView {
    
    public lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Title Label"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = titleLabel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
