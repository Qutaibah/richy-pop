//
//  RichImageInput.swift
//  Aucstar
//
//  Created by Qutaibah Essa on 01/07/2020.
//  Copyright © 2020 Qutaibah. All rights reserved.
//

import UIKit

public class RichImageInput: UIView {
    
    public var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    public var didTapChange: (() -> Void)?

    public var title: String? {
        didSet {
            titleLabel.text = title
            setNeedsUpdateConstraints()
        }
    }
    
    private lazy
    var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = UIColor.lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    public lazy
    var imageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = Identity.color(.secondary)
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy
    var fieldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy
    var imageButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(didTapChangeImage), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        fieldContainer.layer.borderColor = Identity.color(.primary).cgColor
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private
    func didTapChangeImage() {
        didTapChange?()
    }
        
    private func setupComponents() {
        addSubview(fieldContainer)
        fieldContainer.addSubview(imageView)
        fieldContainer.addSubview(imageButton)
    }

    private func setupConstraints() {
        imageView.anchor(top: fieldContainer.topAnchor,
                         leading: fieldContainer.leadingAnchor,
                         bottom: fieldContainer.bottomAnchor,
                         trailing: fieldContainer.trailingAnchor,
                         topConstant: 0,
                         leadingConstant: 0,
                         bottomConstant: 0,
                         trailingConstant: 0,
                         widthConstant: 0,
                         heightConstant: 0)
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.56).isActive = true
        
        
        imageButton.anchor(top: imageView.topAnchor,
                         leading: imageView.leadingAnchor,
                         bottom: imageView.bottomAnchor,
                         trailing: imageView.trailingAnchor)

        fieldContainer.anchor(top: nil,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         topConstant: 0,
                         leadingConstant: edgeInsets.left,
                         bottomConstant: edgeInsets.bottom,
                         trailingConstant: edgeInsets.right,
                         widthConstant: 0,
                         heightConstant: 0)
        guard title?.isEmpty == false else {
            return fieldContainer.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top).isActive = true
        }
        if titleLabel.superview == nil {
            addSubview(titleLabel)
        }
        titleLabel.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: fieldContainer.topAnchor,
                         trailing: trailingAnchor,
                         topConstant: edgeInsets.top,
                         leadingConstant: edgeInsets.left,
                         bottomConstant: 5,
                         trailingConstant: edgeInsets.right,
                         widthConstant: 0,
                         heightConstant: 0)
    }
    
    public override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
}

