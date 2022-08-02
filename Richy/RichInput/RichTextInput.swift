//
//  RichTextInput.swift
//  Richy
//
//  Created by Qutaibah Essa on 19/04/2020.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit

public class RichTextInput: BaseView {
        
    public var textField: UITextField {
        return field.textField
    }
    
    public var didChangeText: ((String) -> Void)? {
        didSet {
            field.onValueChange = didChangeText
        }
    }

    public var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    public lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Identity.font(.custom(weight: .medium, size: 12))
        lbl.textColor = Identity.color(.lightGray)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var field: RichTextField = {
        let view = RichTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainContentStackView: UIStackView = {
        let stk = UIStackView()
        stk.axis = .horizontal
        stk.distribution = .fill
        stk.alignment = .fill
        stk.spacing = 10
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    lazy var stackView: UIStackView = {
        let stk = UIStackView()
        stk.axis = .vertical
        stk.distribution = .fill
        stk.alignment = .fill
        stk.spacing = 5
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        mainContentStackView.addArrangedSubview(field)
        stackView.addArrangedSubview(mainContentStackView)
        contentView = stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func becomeFirstResponder() -> Bool {
        return field.becomeFirstResponder()
    }
    
    public func setTitle(title: String?) {
        guard let title = title else {
            stackView.removeArrangedSubview(titleLabel)
            return
        }
        titleLabel.text = title
        stackView.insertArrangedSubview(titleLabel, at: 0)
    }
    
    public func setAccessoryView(_ view: UIView) {
        mainContentStackView.arrangedSubviews.forEach { [weak self] (view) in
            guard view != self?.field else { return }
            self?.mainContentStackView.removeArrangedSubview(view)
        }
        mainContentStackView.addArrangedSubview(view)
    }
}
