//
//  Dimentions.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit

extension Identity {
    
    struct Dimension {
        
        public static var borderWidth: CGFloat {
            return 1
        }
        
        public static var cornerRadius: CGFloat {
            return 16
        }
        
        public static var alertActionHeight:  CGFloat {
            return 39
        }
        
        public static var alertActionCornerRadius:  CGFloat {
            return alertActionHeight / 2
        }
    }
}
