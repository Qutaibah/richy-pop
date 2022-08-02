//
//  RichAlertExampleView.swift
//  Richy-Example
//
//  Created by Qutaibah Essa on 21/04/2020.
//  Copyright © 2020 MRSOOL. All rights reserved.
//

import UIKit
import Richy

protocol RichAlertExampleViewDataSource: class {
    func items(for view: RichAlertExampleView) -> [RichAlertExampleCell.Entity]
}

protocol RichAlertExampleViewDelegate: class {
    func view(_ view: RichAlertExampleView, didSelect item: RichAlertExampleCell.Entity)
}

class RichAlertExampleView: UIView {
    
    var items: [RichAlertExampleCell.Entity]!
    
    weak var delegate: RichAlertExampleViewDelegate?
    weak var dataSource: RichAlertExampleViewDataSource?
    
    fileprivate lazy var tableView: UITableView = {
        let tbl = UITableView()
        tbl.delegate = self
        tbl.dataSource = self
        tbl.separatorStyle = .singleLine
        tbl.tableFooterView = UIView()
        tbl.register(RichAlertExampleCell.self, forCellReuseIdentifier: RichAlertExampleCell.id)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func reloadData() {
        items = dataSource?.items(for: self)
        tableView.reloadData()
    }
}

extension RichAlertExampleView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        delegate?.view(self, didSelect: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RichAlertExampleView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RichAlertExampleCell.id, for: indexPath) as? RichAlertExampleCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.item = item
        return cell
    }
}


class RichAlertExampleCell: UITableViewCell {
    static var id: String = "RichAlertExampleCell"
    
    struct Entity {
        var title: String
        var isSelected: Bool
        var object: RichAlertController.ContentStyle
        
        mutating func reverseSelection() {
            isSelected = !isSelected
        }
    }
    
    var item: Entity? {
        didSet {
            title.text = item?.title
            backgroundColor = item?.isSelected == true ? .gray : .white
        }
    }
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "This is a new label"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lbl.textColor = UIColor(red: 0.28, green: 0.11, blue: 0.04, alpha: 1)
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        contentView.addSubview(title)
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
    }
}
