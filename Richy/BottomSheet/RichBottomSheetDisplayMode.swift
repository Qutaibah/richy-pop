//
//  RichyBottomSheetDisplayMode.swift
//  Richy
//
//  Created by Irakli Vashakidze on 6/9/20.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit

public enum RichBottomSheetDisplayMode {
    case quarterScreen
    case halfScreen
    case fullScreen
    case custom(height: CGFloat)
    
    var ratio: CGFloat? {
        switch self {
        case .quarterScreen: return 0.25
        case .halfScreen: return 0.5
        case .fullScreen: return 1
        default: return nil
        }
    }
    
    var isCustom: Bool {
        switch self {
        case .custom(_): return true
        default: return false
        }
    }
    
    var customHeight: CGFloat {
        switch self {
        case .custom(let height):
            return min(UIScreen.main.bounds.size.height - 40 , height)
        default: return 0
        }
    }
    
    var constant: CGFloat {
        switch self {
        case .fullScreen: return -40
        default: return 0
        }
    }
}
