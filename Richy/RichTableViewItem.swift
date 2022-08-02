//
//  RichTableViewItem.swift
//  Aucstar
//
//  Created by Qutaibah Essa on 30/06/2020.
//  Copyright © 2020 Qutaibah. All rights reserved.
//

import UIKit

public class RichTableViewItem: UIView {
    
    lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "label"
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.textColor = UIColor.gray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var icon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = Identity.color(.primary)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    public init(icon: String, title: String) {
        super.init(frame: .zero)
        self.title.text = title
        self.icon.setImage(source: RichAlertController.ImageSource.url(icon))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(icon)
        addSubview(title)
        
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalTo: icon.heightAnchor).isActive = true

        title.topAnchor.constraint(equalTo: icon.topAnchor, constant: 0).isActive = true
        title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: icon.bottomAnchor, constant: 0).isActive = true
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        icon.layer.cornerRadius = icon.frame.height / 2
    }
}
