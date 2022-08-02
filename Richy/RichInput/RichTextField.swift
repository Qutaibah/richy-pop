//
//  RichTextField.swift
//  Richy
//
//  Created by Qutaibah Essa on 05/07/2020.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit

public class RichTextField: BaseView {
            
    public var onValueChange: ((String) -> Void)?
    
    public lazy var textField: UITextField = {
       let txt = UITextField()
        txt.font = Identity.font(.h5)
        txt.textColor = Identity.color(.darkGray)
        txt.addTarget(self, action: #selector(textHasChanged(_:)), for: .editingChanged)
        txt.adjustsFontSizeToFitWidth = true
        txt.minimumFontSize = 13
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private lazy var fieldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = Identity.color(.primary).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        fieldContainer.addSubview(textField)
        contentInsets = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        edgeInsets = UIEdgeInsets.zero
        contentView = fieldContainer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textHasChanged(_ sender: UITextField) {
        onValueChange?(sender.text ?? "")
    }
        
    public override func updateConstraints() {
        textField.anchor(top: fieldContainer.topAnchor,
                         leading: fieldContainer.leadingAnchor,
                         bottom: fieldContainer.bottomAnchor,
                         trailing: fieldContainer.trailingAnchor,
                         topConstant: contentInsets.top,
                         leadingConstant: contentInsets.left,
                         bottomConstant: contentInsets.bottom,
                         trailingConstant: contentInsets.right,
                         widthConstant: 0,
                         heightConstant: 30)
        super.updateConstraints()
    }
    
    public override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
}
