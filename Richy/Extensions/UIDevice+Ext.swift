//
//  UIDevice+Ext.swift
//  Richy
//
//  Created by Irakli Vashakidze on 6/8/20.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit

extension UIDevice {
    static var bottomNotchHeight: CGFloat {
        var bottomSafeArea: CGFloat
        if #available(iOS 11.0, *) {
            bottomSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottomSafeArea
        }
        return 0
    }
}
