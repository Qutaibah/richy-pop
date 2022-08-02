//
//  ExampleController.swift
//  Richy
//
//  Created by Qutaibah Essa on 02/11/2019.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

enum Components: String, CaseIterable {
    case RichAlertController
    case RichButton
    case RichInput
}

class ExampleController: UIViewController {
        
    let ui = ExampleView()
    var items: [ExampleViewCell.Entity] = []
    
    override func loadView() {
        ui.delegate = self
        ui.dataSource = self
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        items = Components.allCases.map({ ExampleViewCell.Entity(title: $0.rawValue) })
        ui.reloadData()
    }
}

extension ExampleController: ExampleViewDataSource {
    
    func items(for view: ExampleView) -> [ExampleViewCell.Entity] {
        return items
    }
}

extension ExampleController: ExampleViewDelegate {
    
    func view(_ view: ExampleView, didSelect item: ExampleViewCell.Entity) {
        switch Components(rawValue: item.title) {
        case .RichAlertController:
            navigationController?.pushViewController(RichAlertExampleController(), animated: true)
        case .RichButton:
            navigationController?.pushViewController(RichButtonExampleController(), animated: true)
        case .RichInput:
            navigationController?.pushViewController(RichInputExampleController(), animated: true)
        case .none:
            break
        }
    }
}

public extension UIEdgeInsets {
    
    static var tens: UIEdgeInsets {
        return fixed(10)
    }
    
    static func fixed(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}
