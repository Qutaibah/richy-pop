//
//  RichAlertExampleController.swift
//  Richy-Example
//
//  Created by Qutaibah Essa on 21/04/2020.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit
import Richy

class RichAlertExampleController: UIViewController {
        
    var barButton: UIBarButtonItem!
    var dismissable: Bool = true
    
    let ui = RichAlertExampleView()
    var items: [RichAlertExampleCell.Entity] = []
    
    override func loadView() {
        ui.delegate = self
        ui.dataSource = self
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = "This is the body that can go as long as you want, but be carful not to take the whole screen with it"
        let imageURL = "https://icons.iconarchive.com/icons/thesquid.ink/free-flat-sample/icons-390.jpg"
        let iconURL = "https://www.monarch.edu.au/wp-content/uploads/2019/02/Tick-image.jpg"
        
        barButton = UIBarButtonItem(title: "Alert", style: .plain, target: self, action: #selector(showNativeAlert))
        
        let button = UIBarButtonItem(title: "Action Sheet", style: .plain, target: self, action: #selector(showNativeAlert))
        navigationItem.setRightBarButtonItems([barButton, button], animated: true)

        let e1 = RichAlertExampleCell.Entity(title: "Banner Image", isSelected: false,
                                             object: RichAlertController.ContentStyle.image(.url(imageURL), insets: UIEdgeInsets(top: -24, left: -24, bottom: 0, right: -24)))
        
        let e2 = RichAlertExampleCell.Entity(title: "Icon", isSelected: false,
                                             object: RichAlertController.ContentStyle.icon(.url(iconURL), insets: .tens))
        
        let e3 = RichAlertExampleCell.Entity(title: "Title", isSelected: false,
                                            object: RichAlertController.ContentStyle.title("This is the two lined title, with bold font", insets: .tens))
        
        let e4 = RichAlertExampleCell.Entity(title: "Text", isSelected: false,
        object: RichAlertController.ContentStyle.text(text, insets: .tens))
        
        let e5 = RichAlertExampleCell.Entity(title: "Text Filed", isSelected: false,
                                             object: RichAlertController.ContentStyle.field(title: "Optional title", placeholder: "", text: "sample value", didChange: { (_) in }, insets: .tens))
        
        let tag1 = RichButton(type: .filled(.primary), title: "Tag 1", image: #imageLiteral(resourceName: "icPopupClose"), semantic: .reversed, contentInset: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15), actionHandler: nil)
        tag1.titleLabel.font = Identity.font(.custom(weight: .regular, size: 12))
        let tag2 = RichButton(type: .filled(.secondary), title: "Tag 2", image: #imageLiteral(resourceName: "icPopupClose"), contentInset: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15), actionHandler: nil)
        tag2.titleLabel.font = Identity.font(.custom(weight: .regular, size: 12))
        let e6 = RichAlertExampleCell.Entity(title: "Tags", isSelected: false,
                                             object: RichAlertController.ContentStyle.richTags(title: "Optional Title", buttons: [tag1, tag2], insets: .tens))
        
        let actions = [RichButton(type: .filled(.primary), title: "Action 1"),
                       RichButton(type: .filled(.secondary), image: #imageLiteral(resourceName: "delete")),
                       RichButton(type: .filled(.destructive), title: "Action 3", image: #imageLiteral(resourceName: "delete"))]
        
        let e7 = RichAlertExampleCell.Entity(title: "Actions", isSelected: false,
                                        object: RichAlertController.ContentStyle.actions(buttons: actions.reversed()))
        
        let e8 = RichAlertExampleCell.Entity(title: "Collection 1", isSelected: false,
        object: RichAlertController.ContentStyle.image(.image(#imageLiteral(resourceName: "swift-1")), insets: .tens))
        
        let e9 = RichAlertExampleCell.Entity(title: "Collection 2", isSelected: false,
        object: RichAlertController.ContentStyle.image(.image(#imageLiteral(resourceName: "swift-1")), insets: .tens))
        
        let e10 = RichAlertExampleCell.Entity(title: "Collection 3", isSelected: false,
        object: RichAlertController.ContentStyle.image(.image(#imageLiteral(resourceName: "swift-1")), insets: .tens))
        
        items = [e1,e2,e3,e4,e5,e6,e7,e8,e9,e10]
        ui.reloadData()
    }
    
    @objc func showNativeAlert(_ sender: UIBarButtonItem) {
        let content = items.filter({ $0.isSelected }).map({ $0.object })
        let alert = RichAlertController(type: sender == barButton ? .alert : .actionSheet,
                                        contents: content,
                                        dismissable: dismissable)
        self.present(alert, animated: true, completion: nil)
    }
}

extension RichAlertExampleController: RichAlertExampleViewDataSource {
    
    func items(for view: RichAlertExampleView) -> [RichAlertExampleCell.Entity] {
        return items
    }
}

extension RichAlertExampleController: RichAlertExampleViewDelegate {
    
    func view(_ view: RichAlertExampleView, didSelect item: RichAlertExampleCell.Entity) {
        let title = "Title here for dailogs on two line  can be"
        let message = "Here is the body text of the dailog with multiple line to show who it will be it it host big paragraph like this one here"
        let message2 = "Are you sure you want to delete this item from the cart?"
        
        switch item.title {
        case "Collection 1":
            let controller = RichAlertController.prompt(title: title, message: message, approve: "Okay", decline: "Close")
            self.present(controller, animated: true, completion: nil)
        case "Collection 2":
            let controller = RichAlertController.alert(title: title, message: message, confirm: "Okay")
            self.present(controller, animated: true, completion: nil)
        case "Collection 3":
            let controller = RichAlertController.destructive(icon: .image(#imageLiteral(resourceName: "delete")), title: nil, message: message2, approve: "Delete", decline: "Close")
            self.present(controller, animated: true, completion: nil)
        default:
            let index = items.firstIndex(where: { $0.title == item.title })?.distance(to: 0) ?? 0
            let i = (index) * -1
            var newItem = items[i]
            newItem.reverseSelection()
            items.remove(at: i)
            items.insert(newItem, at: i)
            ui.reloadData()
        }
    }
}
