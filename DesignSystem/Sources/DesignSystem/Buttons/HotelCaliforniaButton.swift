//
//  File 2.swift
//  
//
//  Created by Dinmukhamed on 13.09.2023.
//

import UIKit

public enum ButtonStates {
    case `default`
    case hover
    case disabled
}

public enum ButtonHeight: CGFloat {
    case S = 32
    case M = 48
    case L = 56
}

protocol ConfigurableButton {
    var height: ButtonHeight { get set }
    var onTap: (() -> Void)? { get set }
    
    func setTitle(_ text: String?)
    func setState(_ state: ButtonStates)
    func setLeftImage(_ image: UIImage)
    func showLoading()
    func hideLoading()
}

open class HotelCaliforniaButton: UIControl, ConfigurableButton {
    
    let activityIndicator = UIActivityIndicatorView()
    let leftImageView = UIImageView()
    let titleLabel = UILabel()
    let contentStackView = UIStackView()
    
    public var height: ButtonHeight
    public var onTap: (() -> Void)?
    
    public init(
         height: ButtonHeight,
         leftImage: UIImage? = nil,
         titleText: String? = nil
    ) {
        self.height = height
        self.buttonState = .default
        super.init(frame: .zero)
        setTitle(titleText)
        configureUI()
        configureTitleLabel()
        configureActivityIndicator()
        configureLeftImage(leftImage)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitle(_ text: String?) {
        self.titleLabel.text = text
    }
    
    public func setState(_ state: ButtonStates) {
        self.buttonState = state
    }
    
    public func setLeftImage(_ image: UIImage) {
        self.leftImageView.image = image
    }
    
    public func showLoading() {
        UIView.animate(withDuration: 0.3) {
            self.contentStackView.alpha = 0
            self.activityIndicator.alpha = 1.0
        } completion: { _ in
            self.contentStackView.isHidden = true
            self.isUserInteractionEnabled = false
            self.activityIndicator.startAnimating()
        }
    }
    
    public func hideLoading() {
        UIView.animate(withDuration: 0.3) {
            self.contentStackView.alpha = 1.0
            self.activityIndicator.alpha = 0.0
        } completion: { _ in
            self.activityIndicator.stopAnimating()
            self.contentStackView.isHidden = false
            self.isUserInteractionEnabled = true
        }
    }
    
    // MARK: Internal overridable
    var buttonState: ButtonStates {
        didSet {
            configureState()
        }
    }

    func configureState() { }
    
    func configureUI() {
        addTarget(self, action: #selector(touchedDown), for: .touchDown)
        addTarget(self, action: #selector(touchedUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(touchedUpOutside), for: .touchUpOutside)
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.snp.makeConstraints { make in
            make.height.equalTo(height.rawValue)
        }
        layer.cornerRadius = 15
    }
    
    override open var intrinsicContentSize: CGSize {
        let width: CGFloat = super.intrinsicContentSize.width
        return .init(width: width, height: height.rawValue)
    }
    
    // For handling click by stackView
    open override func hitTest(_ point: CGPoint, with event: UIEvent? ) -> UIView? {
        guard self.point(inside: point, with: event) else { return nil }
        return self
    }
}

// MARK: - Private

private extension HotelCaliforniaButton {
    func configureActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator.style = .medium
        } else {
            // Fallback on earlier versions
        }
        addSubview(activityIndicator)
        activityIndicator.alpha = 0.0
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureTitleLabel() {
        guard titleLabel.text != nil else { return }
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.spacing = 8
    }
    
    func configureLeftImage(_ leftImage: UIImage?) {
        if let leftImage = leftImage {
            leftImageView.image = leftImage
            contentStackView.insertArrangedSubview(leftImageView, at: 0)
            leftImageView.snp.makeConstraints { make in
                make.width.height.equalTo(24)
            }
        }
    }
    
    @objc func touchedDown() {
        pressDown()
    }

    @objc func touchedUpInside(sender: UIControl, event: UIEvent) {
        pressUp()
        guard let currentTouch = event.allTouches?.first else { return }
        let touchLoc = currentTouch.location(in: self)
        if touchLoc.x < sender.frame.width &&
            touchLoc.x > 0 &&
            touchLoc.y < sender.frame.height &&
            touchLoc.y > 0 {
            onTap?()
        }
    }

    @objc func touchedUpOutside() {
        pressUp()
    }

    func pressDown() {
        buttonState = .hover
    }

    func pressUp() {
        buttonState = .default
    }
}
