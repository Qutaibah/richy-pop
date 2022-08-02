//
//  RichTableView.swift
//  Aucstar
//
//  Created by Qutaibah Essa on 01/07/2020.
//  Copyright © 2020 Qutaibah. All rights reserved.
//

import UIKit

open class RichTableView: UIView {
    
    public struct Section {
        var header: HeaderFooterType?
        var footer: HeaderFooterType?
        var rows: [Row]
        
        public init(header: HeaderFooterType? = nil, footer: HeaderFooterType? = nil, rows: [Row]) {
            self.header = header
            self.footer = footer
            self.rows = rows
        }
    }
    
    public enum HeaderFooterType {
        case title(String)
        case view(UITableViewHeaderFooterView)
        case spaced(CGFloat)
    }
    
    public struct Row {
        let view: UIView
        let backgroundColor: UIColor
        let accessoryType: UITableViewCell.AccessoryType
        let didTap: (() -> Void)?
        
        public init(view: UIView, accessoryType: UITableViewCell.AccessoryType = .none, backgroundColor: UIColor = .white, didTap: (() -> Void)? = nil) {
            self.view = view
            self.accessoryType = accessoryType
            self.didTap = didTap
            self.backgroundColor = backgroundColor
        }
    }
    
    public var sections: [Section]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tableViewStyle: UITableView.Style
    public lazy var tableView: UITableView = {
        let tbl = UITableView(frame: .zero, style: tableViewStyle)
        tbl.dataSource = self
        tbl.delegate = self
        tbl.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tbl.register(RichTableViewCell.self, forCellReuseIdentifier: RichTableViewCell.id)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    public init(style: UITableView.Style? = nil) {
        if let style = style {
            tableViewStyle = style
        } else {
            tableViewStyle = .groupedForOS
        }
        super.init(frame: .zero)
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RichTableView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        row.didTap?()
    }
}

extension RichTableView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let header = sections[section].header, case let HeaderFooterType.title(value) = header else { return nil }
        return value
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = sections[section].header, case let HeaderFooterType.view(value) = header else { return nil }
        return value
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let footer = sections[section].footer, case let HeaderFooterType.title(value) = footer else { return nil }
        return value
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = sections[section].footer, case let HeaderFooterType.view(value) = footer else { return nil }
        return value
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = .red
    }

    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        view.tintColor = .clear
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let header = sections[section].header else { return 0 }
        guard case let HeaderFooterType.spaced(value) = header else { return UITableView.automaticDimension }
        return value
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footer = sections[section].footer else { return 0 }
        guard case let HeaderFooterType.spaced(value) = footer else { return UITableView.automaticDimension }
        return value
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RichTableViewCell.id, for: indexPath) as? RichTableViewCell else {
            return UITableViewCell()
        }
        cell.contentView.subviews.first(where: { $0.tag == 999 })?.removeFromSuperview()
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        let view = row.view
        
        cell.accessoryType = row.accessoryType
        cell.backgroundColor = row.backgroundColor
        cell.contentView.backgroundColor = row.backgroundColor

        view.tag = 999
        view.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class RichTableViewCell: UITableViewCell {
    static let id = "RichTableViewCell"
}

public extension UITableView.Style {
    static var groupedForOS: UITableView.Style {
        if #available(iOS 13, *) {
            return .insetGrouped
        } else {
            return .grouped
        }
    }
}
