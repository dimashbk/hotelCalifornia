import UIKit

public class FloatingTextField: UITextField {
    
    public enum FloatingDisplayStatus {
        case always
        case never
        case defaults
    }
    
    public var lblFloatPlaceholder = UILabel()
    fileprivate let paddingX: CGFloat = 5.0
    fileprivate let paddingHeight: CGFloat = 8.0
    fileprivate var borderLayer: CALayer = CALayer()
    public var dtLayer: CALayer = CALayer()
    public var floatPlaceholderColor: UIColor = .lightGray
    public var floatPlaceholderActiveColor: UIColor = .lightGray
    public var floatingLabelShowAnimationDuration = 0.3
    public var floatingDisplayStatus: FloatingDisplayStatus = .defaults
    
    public var animateFloatPlaceholder: Bool = true

    public var floatPlaceholderFont = UIFont.systemFont(ofSize: 12, weight: .medium) {
        didSet {
            lblFloatPlaceholder.font = floatPlaceholderFont
            invalidateIntrinsicContentSize()
        }
    }
    
    public var paddingYFloatLabel: CGFloat = 10.0 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    public var placeholderColor: UIColor? {
        didSet {
            guard let color = placeholderColor else { return }
            attributedPlaceholder = NSAttributedString(string: placeholderFinal,
                                                       attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }
     
    fileprivate var x: CGFloat {
        
        if let leftView = leftView {
            return leftView.frame.origin.x + leftView.bounds.size.width - paddingX
        }
        
        return paddingX
    }
    
    fileprivate var fontHeight: CGFloat {
        return ceil(font!.lineHeight)
    }
    
    fileprivate var floatLabelWidth: CGFloat {
        
        var width = bounds.size.width
        
        if let leftViewWidth = leftView?.bounds.size.width {
            width -= leftViewWidth
        }
        
        if let rightViewWidth = rightView?.bounds.size.width {
            width -= rightViewWidth
        }
        
        return width - (self.x * 2)
    }
    
    fileprivate var placeholderFinal: String {
        if let attributed = attributedPlaceholder { return attributed.string }
        return placeholder ?? " "
    }
    
    fileprivate var isFloatLabelShowing: Bool = false
    
    public override var isSecureTextEntry: Bool {
        didSet {
            guard isFirstResponder else { return }
            _ = becomeFirstResponder()
        }
    }
    
    public override func becomeFirstResponder() -> Bool {
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
    
    override public var borderStyle: UITextField.BorderStyle {
        didSet {
            guard borderStyle != oldValue else { return }
            borderStyle = .none
        }
    }
    
    public override var textAlignment: NSTextAlignment {
        didSet { setNeedsLayout() }
    }

    override public var placeholder: String? {
        didSet {
            guard let color = placeholderColor else {
                lblFloatPlaceholder.text = placeholderFinal
                return
            }
            attributedPlaceholder = NSAttributedString(string: placeholderFinal,
                                                       attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }
    
    override public var attributedPlaceholder: NSAttributedString? {
        didSet { lblFloatPlaceholder.text = placeholderFinal }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        self.font = UIFont.systemFont(ofSize: 16)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    fileprivate func commonInit() {
        
        floatPlaceholderColor       = .lightGray
        floatPlaceholderActiveColor = .lightGray
        lblFloatPlaceholder.frame   = CGRect.zero
        lblFloatPlaceholder.alpha   = 0.0
        lblFloatPlaceholder.font    = floatPlaceholderFont
        lblFloatPlaceholder.text    = placeholderFinal
        
        addSubview(lblFloatPlaceholder)
        
        layer.insertSublayer(dtLayer, at: 0)
    }
    
    func setFloatLabelAlignment() {
        var newFrame = lblFloatPlaceholder.frame
        
        if textAlignment == .right {
            newFrame.origin.x = bounds.width - paddingX - newFrame.size.width
        } else if textAlignment == .left {
            newFrame.origin.x = paddingX
        } else if textAlignment == .center {
            newFrame.origin.x = (bounds.width / 2.0) - (newFrame.size.width / 2.0)
        }
        lblFloatPlaceholder.frame = newFrame
        
    }
    
    fileprivate func showFloatingLabel(_ animated: Bool) {
        
        let animations: (() -> ()) = {
            self.lblFloatPlaceholder.alpha = 1.0
            self.lblFloatPlaceholder.frame = CGRect(x: self.lblFloatPlaceholder.frame.origin.x,
                                                    y: self.paddingYFloatLabel,
                                                    width: self.lblFloatPlaceholder.bounds.size.width,
                                                    height: self.lblFloatPlaceholder.bounds.size.height)
            self.font = UIFont.systemFont(ofSize: 12)
        }
        
        if animated && animateFloatPlaceholder {
            UIView.animate(withDuration: floatingLabelShowAnimationDuration,
                           delay: 0.0,
                           options: [.beginFromCurrentState, .curveEaseOut],
                           animations: animations) { _ in
                self.layoutIfNeeded()
                let attributedString = NSAttributedString(string: self.placeholderFinal, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0)])
                self.attributedPlaceholder = attributedString
            }
        } else {
            animations()
        }
    }
    
    fileprivate func hideFloatingLabel(_ animated: Bool) {
        
        let animations: (() -> ()) = {
            self.lblFloatPlaceholder.alpha = 0.0
            self.lblFloatPlaceholder.frame = CGRect(x: self.lblFloatPlaceholder.frame.origin.x,
                                                    y: self.lblFloatPlaceholder.font.lineHeight,
                                                    width: self.lblFloatPlaceholder.bounds.size.width,
                                                    height: self.lblFloatPlaceholder.bounds.size.height)
            self.font = UIFont.systemFont(ofSize: 16)
        }
        
        if animated && animateFloatPlaceholder {
            UIView.animate(withDuration: floatingLabelShowAnimationDuration,
                           delay: 0.0,
                           options: [.beginFromCurrentState, .curveEaseOut],
                           animations: animations) { _ in
                                self.layoutIfNeeded()
            }
        } else {
            animations()
        }
    }
    
    fileprivate func insetRectForEmptyBounds(rect: CGRect) -> CGRect {
        let newX = x
        return CGRect(x: newX, y: 0, width: rect.width - newX - paddingX, height: rect.height)
    }
        
    fileprivate func insetRectForBounds(rect: CGRect) -> CGRect {
        
        guard let placeholderText = lblFloatPlaceholder.text, !placeholderText.isEmptyStr  else {
            return insetRectForEmptyBounds(rect: rect)
        }
        
        if floatingDisplayStatus == .never {
            return insetRectForEmptyBounds(rect: rect)
        } else {
            if let text = text, text.isEmptyStr && !isFirstResponder {
                return insetRectForEmptyBounds(rect: rect)
            } else {
                let topInset = paddingYFloatLabel + lblFloatPlaceholder.bounds.size.height + (paddingHeight / 2.0)
                let textOriginalY = (rect.height - fontHeight) / 2.0
                let textY = topInset - textOriginalY
                
                let newX = x
                return CGRect(x: newX, y: ceil(textY), width: rect.size.width - newX - paddingX, height: rect.height)
            }
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        
        let textFieldIntrinsicContentSize = super.intrinsicContentSize

        return CGSize(width: textFieldIntrinsicContentSize.width,
                      height: textFieldIntrinsicContentSize.height +
                              paddingYFloatLabel +
                              lblFloatPlaceholder.bounds.size.height +
                              paddingHeight)
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return insetRectForBounds(rect: rect)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return insetRectForBounds(rect: rect)
    }
    
    fileprivate func insetForSideView(forBounds bounds: CGRect) -> CGRect {
        var rect = bounds
        rect.origin.y = 0
        return rect
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        dtLayer.frame = CGRect(x: bounds.origin.x,
                               y: bounds.origin.y,
                               width: bounds.width,
                               height: bounds.height)
        CATransaction.commit()
        
        let floatingLabelSize = lblFloatPlaceholder.sizeThatFits(lblFloatPlaceholder.superview!.bounds.size)
        
        lblFloatPlaceholder.frame = CGRect(x: x, y: lblFloatPlaceholder.frame.origin.y,
                                           width: floatingLabelSize.width,
                                           height: floatingLabelSize.height)

        setFloatLabelAlignment()
        lblFloatPlaceholder.textColor = isFirstResponder ? floatPlaceholderActiveColor : floatPlaceholderColor
        
        switch floatingDisplayStatus {
        case .never:
            hideFloatingLabel(isFirstResponder)
        case .always:
            showFloatingLabel(isFirstResponder)
        default:
            if let enteredText = text, (!enteredText.isEmptyStr) || isFirstResponder {
                showFloatingLabel(isFirstResponder)
            } else {
                hideFloatingLabel(isFirstResponder)
            }
        }
    }

}

public extension String {
    
    var isEmptyStr: Bool {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
}
