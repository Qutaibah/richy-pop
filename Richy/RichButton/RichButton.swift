//
//  RichButton.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

public class RichButton: UIView {
        
    var didTap: ((RichButton) -> Void)?
    
    public var type: ButtonType {
        didSet {
            updateColors()
        }
    }

    private var highlightingEffect: HighlightingEffect = .system
    
    var isSelected: Bool = false
    
    var isEnabled: Bool = true {
        didSet {
            isUserInteractionEnabled = isEnabled
            updateColors()
            updateShadow()
        }
    }
    
    private var isHighlighted = false {
        didSet {
            animateHighlighted(isHighlighted)
        }
    }
    
    public var title: String? {
        didSet {
            titleLabel.text = title
            titleLabel.isHidden = title == nil
        }
    }
    
    public var image: UIImage? {
        didSet {
            imageView.image = image
            imageView.isHidden = image == nil
        }
    }
    
    public var contentColor: UIColor? {
        didSet {
            titleLabel.textColor = contentColor
            imageView.tintColor = contentColor
        }
    }
    
    private(set) var shadow: Shadow? {
        didSet {
            guard let shadow = shadow, isEnabled else {
                layer.shadowOpacity = 0
                return
            }
            addShadow(ofColor: shadow.color, radius: shadow.radius, offset: shadow.offset, opacity: shadow.opacity)
        }
    }
    
    public var cornerRadius: CGFloat? {
        didSet {
            setNeedsLayout()
        }
    }
    
    public lazy var badgeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = badgeHeight/2
        view.addShadow(ofColor: Identity.color(.red), radius: 4, offset: CGSize(width: 0, height: 2), opacity: 0.49)
        return view
    }()
    
    public lazy var imageView: UIImageView = {
        var img = UIImageView()
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    public private(set) lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Identity.font(.description)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var stackView: UIStackView = {
        let stk = UIStackView()
        stk.axis = .horizontal
        stk.distribution = .fill
        stk.alignment = .center
        stk.spacing = 10
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTapButton))
        return tap
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //  this label is only used to define intrinsic size for the parent view
    lazy var hiddenLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "A"
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    public init(type: ButtonType,
                title: String? = nil,
                image: UIImage? = nil,
                semantic: Semantic = .default,
                contentInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
                highlightingEffect: HighlightingEffect = .system,
                actionHandler: ((RichButton) -> Void)? = nil) {
        self.type = type
        super.init(frame: CGRect.zero)
        isAccessibilityElement = true
        self.highlightingEffect = highlightingEffect
        self.didTap = actionHandler
        setSemantic(semantic)
        updateColors()
        setupUIComponents(title: title, image: image)
        setupUIConstraints(contentInset: contentInset)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let height = heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        height.priority = .defaultLow
        height.isActive = true
    }
    
    public func setShadow(shadowValues s: Shadow?, whenEnabledOnly enabled: Bool = true) {
        if !enabled {
            guard let s = s else {
                shadow = nil
                return
            }
            addShadow(ofColor: s.color, radius: s.radius, offset: s.offset, opacity: s.opacity)
        } else {
            shadow = s
        }
    }
    
    private func animateHighlighted(_ highlighted: Bool) {
        guard isEnabled, highlightingEffect != .none else { return }
        
        let duration = highlighted ? 0.15 : 0.25
        let alpha: CGFloat = highlighted ? 0.4 : 1
        UIView.animate(withDuration: duration) { [weak self] in
            self?.stackView.alpha = alpha
        }
    }
    
    private func setSemantic(_ semantic: Semantic) {
        switch semantic {
        case .default:
            stackView.semanticContentAttribute = .unspecified
            self.semanticContentAttribute = .unspecified
        case .forceLeftToRight:
            stackView.semanticContentAttribute = .forceLeftToRight
            self.semanticContentAttribute = .forceLeftToRight
        case .forceRightToLeft:
            stackView.semanticContentAttribute = .forceRightToLeft
            self.semanticContentAttribute = .forceRightToLeft
        case .reversed:
            if UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
                stackView.semanticContentAttribute = .forceRightToLeft
                self.semanticContentAttribute = .forceRightToLeft
            } else {
                stackView.semanticContentAttribute = .forceLeftToRight
                self.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
    
    private func updateColors() {
        borderView.layer.borderWidth = 0
        switch type {
        case .filled(let style):
            backgroundColor = isEnabled ? style.color : Identity.color(.grayBackground)
            contentColor = isEnabled ? style.textColor : Identity.color(.darkGray)
        case .bordered(let style):
            borderView.layer.borderWidth = 2
            backgroundColor = .clear
            borderView.layer.borderColor = isEnabled ? style.color.cgColor : Identity.color(.darkGray).cgColor
            contentColor = isEnabled ? style.color : Identity.color(.darkGray)
        case .clear(let style):
            backgroundColor = .clear
            contentColor = isEnabled ? style.color : Identity.color(.darkGray)
        case .custom(let background, let content, let border):
            borderView.layer.borderWidth = border == nil ? 0 : 2
            backgroundColor = isEnabled ? background : Identity.color(.grayBackground)
            borderView.layer.borderColor = isEnabled ? border?.cgColor : Identity.color(.darkGray).cgColor
            contentColor = isEnabled ? content : Identity.color(.darkGray)
        }
    }
    
    private func updateShadow() {
        guard let shadow = shadow else { return }
        addShadow(ofColor: shadow.color, radius: shadow.radius, offset: shadow.offset, opacity: shadow.opacity)
    }
    
    private func setupUIComponents(title: String?, image: UIImage?) {
        addSubview(hiddenLabel)
        borderView.layer.cornerRadius = 8
        layer.cornerRadius = 8
        addSubview(stackView)
        self.title = title
        self.image = image

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapButton)))
        
        guard case .bordered(_) = type else { return }
        addSubview(borderView)
        borderView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        borderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        borderView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sendSubviewToBack(borderView)
    }
    
    private func setupUIConstraints(contentInset: UIEdgeInsets) {
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: contentInset.top).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -contentInset.top).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: contentInset.left).isActive = true
//        let trailing = stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -contentInset.right)
//        trailing.priority = .init(999)
//        trailing.isActive = true
//
        hiddenLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 0, leadingConstant: 0, bottomConstant: 0, trailingConstant: 0, widthConstant: 0, heightConstant: 0)
        hiddenLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        hiddenLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        hiddenLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        hiddenLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    @objc func didTapButton() {
        guard isEnabled else { return }
        isSelected = !isSelected
        didTap?(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        borderView.layer.cornerRadius = cornerRadius ?? frame.height / 2
        layer.cornerRadius = cornerRadius ?? frame.height / 2
    }
}

// MARK: - Touches Handling
extension RichButton {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isHighlighted = true
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isHighlighted = false
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let point = firstTouch.location(in: self)
            let distance = point.distance(from: CGPoint(x: bounds.midX, y: bounds.midY))
            if distance >= 120 {
                isHighlighted = false
                super.touchesCancelled(touches, with: event)
                return
            }
        }
        super.touchesMoved(touches, with: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isHighlighted = false
    }
}
