//
//  TextView.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

public class TextView: BaseView {
        
    var alignment: NSTextAlignment = .center {
        didSet {
            textLabel.textAlignment = alignment
        }
    }

	private lazy var textLabel: UILabel = {
		let lbl = UILabel()
		lbl.numberOfLines = 0
		lbl.font = Identity.font(.h5)
		lbl.textColor = Identity.color(.lightGray)
        lbl.textAlignment = .center
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()

	public init(text: String) {
		super.init(frame: .zero)
		textLabel.text = text
        contentView = textLabel
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}
}
