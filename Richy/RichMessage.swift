//
//  RichMessage.swift
//  Aucstar
//
//  Created by Qutaibah Essa on 28/06/2020.
//  Copyright © 2020 Qutaibah. All rights reserved.
//

import UIKit

public class RichMessage: UIView {
    
    public struct Entity {
        let title: String
        let message: String
        let type: MessageType
        let actions: [UIView]
        
        public init(title: String, message: String, type: MessageType, actions: [UIView]) {
            self.title = title
            self.message = message
            self.type = type
            self.actions = actions
        }
    }
    
    public enum MessageType {
        case primary
        case warning
        case error
        case success
        
        var color: UIColor {
            switch self {
            case .primary:
                return Identity.color(.primary)
            case .warning:
                return UIColor.yellow
            case .error:
                return UIColor.red
            case .success:
                return UIColor.green
            }
        }
        
        public var richActionType: RichButton.ButtonType {
            switch self {
            case .error:
                return .filled(.secondary)
            case .warning:
                return .filled(.secondary)
            case .success:
                return .filled(.secondary)
            case .primary:
                return .filled(.secondary)
            }
        }
    }
    
    private var item: Entity
        
    lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "label"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        lbl.textColor = UIColor.white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var lblMessage: UILabel = {
        let lbl = UILabel()
        lbl.text = "label"
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = UIColor.white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var stackView: UIStackView = {
        let stk = UIStackView()
        stk.distribution = .fillEqually
        stk.alignment = .fill
        stk.axis = .horizontal
        stk.spacing = 10
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    public init(item: Entity) {
        self.item = item
        super.init(frame: .zero)
        self.backgroundColor = Identity.color(.primary)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        lblTitle.text = item.title
        lblMessage.text = item.message
        backgroundColor = item.type.color
        for view in item.actions {
            stackView.addArrangedSubview(view)
        }
        stackView.axis = item.actions.count > 2 ? .vertical : .horizontal
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(lblTitle)
        addSubview(lblMessage)

        lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true

        lblMessage.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        lblMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lblMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        guard !item.actions.isEmpty else {
            return lblMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        }
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
}
