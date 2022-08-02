//
//  RichTags.swift
//  Richy
//
//  Created by Qutaibah Essa on 19/04/2020.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit

public class RichTags: UIView {
    
    public var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    
    public var tagsViewHeight: CGFloat? {
        didSet {
            setNeedsUpdateConstraints()
            collectionView.reloadData()
        }
    }

    public var tagsHeight: CGFloat = 24 {
        didSet {
            setNeedsUpdateConstraints()
            collectionView.reloadData()
        }
    }
    
    private var buttons: [RichButton]?
    private var tags: [String]?
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Identity.font(.custom(weight: .medium, size: 12))
        lbl.textColor = Identity.color(.lightGray)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = RichTagsFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = nil
        cv.register(RichTagsCell.self, forCellWithReuseIdentifier: RichTagsCell.id)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    public init(title: String? = nil, buttons: [RichButton]) {
        self.buttons = buttons
        super.init(frame: .zero)
        titleLabel.text = title
        setupComponents(hasTitle: title != nil)
    }
    
    init(title: String? = nil, tags: [String]) {
        self.tags = tags
        super.init(frame: .zero)
        titleLabel.text = title
        setupComponents(hasTitle: title != nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponents(hasTitle: Bool) {
        addSubview(collectionView)
        guard hasTitle else { return }
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        collectionView.anchor(top: nil,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         topConstant: 0,
                         leadingConstant: edgeInsets.left,
                         bottomConstant: edgeInsets.bottom,
                         trailingConstant: edgeInsets.right,
                         widthConstant: 0,
                         heightConstant: 0)
        if let height = tagsViewHeight {
            collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
        } else {
            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: tagsHeight).isActive = true
        }
        guard titleLabel.superview != nil else {
            return collectionView.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top).isActive = true
        }
        titleLabel.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: collectionView.topAnchor,
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

extension RichTags: UICollectionViewDelegate {
    
}

extension RichTags: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons?.count ?? tags?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RichTagsCell.id, for: indexPath) as? RichTagsCell else { return UICollectionViewCell() }
        if let button = buttons?[indexPath.row] {
            cell.addSubview(button)
            button.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: cell.bottomAnchor, trailing: cell.trailingAnchor, topConstant: 0, leadingConstant: 0, bottomConstant: 0, trailingConstant: 16, widthConstant: 0, heightConstant: tagsHeight)
            return cell
        } else {
            fatalError("Tags Not implemented yet")
        }
    }
}

class RichTagsCell: UICollectionViewCell {
    static let id: String = "RichTagsCell"
}

class RichTagsFlowLayout : UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .vertical
        estimatedItemSize = CGSize(width: 15, height: 30)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
        var leftMargin: CGFloat = 0.0;
        for attributes in attributesForElementsInRect! {
            let refAttributes = attributes
            if (refAttributes.frame.origin.x == self.sectionInset.left) {
                leftMargin = self.sectionInset.left
            } else {
                var newLeftAlignedFrame = refAttributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                refAttributes.frame = newLeftAlignedFrame
            }
            leftMargin += refAttributes.frame.size.width
            newAttributesForElementsInRect.append(refAttributes)
        }
        return newAttributesForElementsInRect
    }
}
