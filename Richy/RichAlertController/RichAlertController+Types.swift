//
//  RichAlertController+Types.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

public extension RichAlertController {
    
    enum Style: Equatable {
        case alert
        case actionSheet
        case popover(source: PopoverSource)
        
        private var id: Int {
            switch self {
            case .alert:
                return 0
            case .actionSheet:
                return 1
            case .popover:
                return 2
            }
        }
        
        public static func ==(lhs: Style, rhs: Style) -> Bool {
            return lhs.id == rhs.id
        }
    }
        
    enum PopoverSource {
        case rect(rect: CGRect, view: UIView)
        case barButton(_ item: UIBarButtonItem)
    }
    
    enum ImageSource {
        case image(UIImage)
        case url(String)
    }
    
    enum ContentStyle {
        case title(_ title: String, insets: UIEdgeInsets?)
        case text(_ text: String, insets: UIEdgeInsets?)
        case webView(url: URL, insets: UIEdgeInsets?)
        case image(_ image: ImageSource, insets: UIEdgeInsets?)
        case icon(_ icon: ImageSource, insets: UIEdgeInsets?)
        case actions(buttons: [RichButton])
        case field(title: String?, placeholder: String? = nil, text: String? = nil, didChange: (String) -> Void, insets: UIEdgeInsets?)
        case richTags(title: String? = nil, buttons: [RichButton], insets: UIEdgeInsets?)
        case custom(view: UIView)
        
        var view: UIView {
            switch self {
            case .title(let title, let insets):
                let view = TitleView(title: title)
                view.edgeInsets = insets ?? .zero
                return view
            case .text(let text, let insets):
                let view = TextView(text: text)
                view.edgeInsets = insets ?? .zero
                return view
            case .webView(let url, let insets):
                let view = WebView(url: url)
                view.edgeInsets = insets ?? .zero
                return view
            case .image(let source, let insets):
                let view = ImageView(source: source)
                view.edgeInsets = insets ?? .zero
                return view
            case .icon(let source, let insets):
                let view = IconView(source: source)
                view.edgeInsets = insets ?? .zero
                return view
            case .field(let title, let placeholder, let text, let didChange, let insets):
                let view = RichTextInput()
                view.setTitle(title: title)
                view.textField.placeholder = placeholder
                view.textField.text = text
                view.didChangeText = didChange
                view.edgeInsets = insets ?? .zero
                return view
            case .richTags(let title, let buttons, let insets):
                let view = RichTags(title: title, buttons: buttons)
                view.edgeInsets = insets ?? .zero
                return view
            case .actions(let buttons):
                let view = ActionsView(actions: buttons, didTap: nil)
                return view
            case .custom(let view):
                return view
            }
        }
    }
}
