//
//  Badgable.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

public protocol Badgable {
    var badgeView: UIView { get set }
    
    func showBadge(text: String, color: UIColor)
    func showBadge(count: Int, maxCount: Int, color: UIColor)
    func hideBadge()
}
