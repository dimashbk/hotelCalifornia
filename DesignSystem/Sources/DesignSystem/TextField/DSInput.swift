//
//  StrongTextField.swift
//
//
//  Created by Dinmukhamed on 08.06.2023.
//

import UIKit

protocol DSTextFieldProtocol {
    var inputHeight: DSTextFieldHeight { get set }
    var editingBegan: ((String) -> Void)? { get set }
    var editingEnded: ((String) -> Void)? { get set }
    var editingChanged: ((String) -> Void)? { get set }
    var willChangeResponder: (() -> Void)? { get set }
}

protocol DSTextFieldStateProtocol {
    func setState(_ state: DSTextFieldState)
    func hideMessage(_ state: DSTextFieldState)
    func showMessage(message: String, state: DSTextFieldState)
}

protocol DSTextFieldConfigurationProtocol {
    func configure(inputConfiguration: DSTextFieldConfiguration)
    var constantText: String { get set }
    var onLeftImageTap: (() -> Void)? { get set }
    var onRightImageTap: (() -> Void)? { get set }
    var keyboardType: UIKeyboardType { get set }
    var leftImage: UIImage? { get set }
    var rightImage: UIImage? { get set }
    var text: String? { get set }
}

typealias ConfigurableInput = DSTextFieldProtocol &
                              DSTextFieldStateProtocol &
                              DSTextFieldConfigurationProtocol

open class DSInput: UIControl, ConfigurableInput, UITextFieldDelegate {

    private var didSetInitialHeight: Bool = false
    var height: CGFloat
    public var constantText: String = ""
    public var keyboardType: UIKeyboardType {
        didSet {
            floatingTextField.keyboardType = keyboardType
        }
    }

    public var shouldChangeCharactersIn: ((_ textField: UITextField, _ range: NSRange, _ replacementString: String) -> Bool)?
    
    /// Use [weak self] in implementation to avoid memory leaks
    public var editingBegan: ((String) -> Void)?
    
    /// Use [weak self] in implementation to avoid memory leaks
    public var editingEnded: ((String) -> Void)?
    
    /// Use [weak self] in implementation to avoid memory leaks
    public var editingChanged: ((String) -> Void)?
    
    /// Use [weak self] in implementation to avoid memory leaks
    public var willChangeResponder: (() -> Void)?

    // Override me by subclasses
    public var inputHeight: DSTextFieldHeight {
        didSet {
            configureHeight()
        }
    }
    
    public var onLeftImageTap: (() -> Void)?
    
    public var onRightImageTap: (() -> Void)?

    var configuration: DSTextFieldConfiguration

    let backgroundView = UIView()
    let textFieldContainerView = UIView()

    public lazy var floatingTextField: FloatingTextField = {
        let textField = FloatingTextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.returnKeyType = .done
        return textField
    }()

    let captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    var inputState: DSTextFieldState {
        didSet {
            configureState()
        }
    }

    // MARK: - ConfigurableInput
    public var text: String? {
        get { return floatingTextField.text }
        set { floatingTextField.text = newValue }
    }

    public var rightImage: UIImage? {
        didSet {
            rightImageView.image = rightImage
        }
    }
    
    public var leftImage: UIImage? {
        didSet {
            leftImageView.image = leftImage
        }
    }
    
    private var captionMessage: String?
    
    // MARK: - Init
    public init() {
        inputState = .default
        inputHeight = .text
        configuration = DSTextFieldConfiguration()
        height = inputHeight.rawValue
        keyboardType = .default
        super.init(frame: .zero)
        floatingTextField.delegate = self
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        guard !didSetInitialHeight else { return }
        height = frame.height
        didSetInitialHeight = true
    }

    // MARK: - Public
    public func configure(inputConfiguration: DSTextFieldConfiguration) {
        self.configuration = inputConfiguration
        self.inputState = .default
        floatingTextField.keyboardType = inputConfiguration.keyBoardType
        configureUI()
    }

    public func setText(_ text: String) {
        floatingTextField.text = text
    }

    public func setState(_ state: DSTextFieldState) {
        self.inputState = state
    }

    public func showMessage(message: String, state: DSTextFieldState) {
        inputState = state
        switch state {
        case .error:
            captionLabel.textColor = .red
            UIView.animate(withDuration: 0.3) {
                self.captionLabel.text = message
                self.layoutIfNeeded()
            }
        default:
            captionLabel.textColor = UIColor.lightGray
            captionLabel.text = message
            captionMessage = message
        }
        
        guard height == inputHeight.rawValue else { return }
        self.snp.updateConstraints { make in
            make.height.equalTo(self.height + self.inputHeight.captionLabelHeight + 4)
        }
    }

    public func hideMessage(_ state: DSTextFieldState) {
        self.captionLabel.text = ""
        switch state {
        case .error:
            captionLabel.textColor = .lightGray
            captionLabel.text = captionMessage ?? ""
        default:
            break
        }
        inputState = .static
        guard captionLabel.text?.isEmpty == true else { return }
        UIView.animate(withDuration: 0.3) {
            self.snp.updateConstraints { make in
                make.height.equalTo(self.inputHeight.rawValue)
            }
        }
    }

    // MARK: - UITextFieldDelegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        willChangeResponder?()
        textField.resignFirstResponder()
        return true
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        inputState = .active
        editingBegan?(text)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        inputState = .static
        configureCloseImage(text)
        editingEnded?(text)
    }

    public func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        configureCloseImage(text)
        editingChanged?(text)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        shouldChangeCharactersIn?(textField, range, string) ?? true
    }
    
    // MARK: - State configuration
    func configureState() {
        switch inputState {
        case .static:
            configureStaticState()
        case .active:
            configureActiveState()
        case .disabled:
            configureDisabledState()
        case .error:
            configureErrorState()
        case .default:
            configureDefaultState()
        }
    }

    func configureUI() {
        configureBackground()
        addSubview(textFieldContainerView)
        configureCaptionLabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(inputTapped))
        let leftTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftImageTaped))
        backgroundView.addGestureRecognizer(tapGesture)
        leftImageView.addGestureRecognizer(leftTapGestureRecognizer)
    }

    // MARK: - Private
    private func configureHeight() {
        self.snp.makeConstraints { make in
            make.height.equalTo(inputHeight.rawValue)
        }
    }

    private func configureBackground() {
        addSubview(backgroundView)
        backgroundView.layer.cornerRadius = 12
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureDefaultState() {
        floatingTextField.isUserInteractionEnabled = true
        textFieldContainerView.backgroundColor = UIColor.secondarySystemBackground
        textFieldContainerView.alpha = 1
        floatingTextField.floatPlaceholderActiveColor = UIColor.lightGray
        floatingTextField.placeholderColor = .lightGray
        floatingTextField.textColor = .lightGray
    }
    
    private func configureStaticState() {
        isUserInteractionEnabled = true
        textFieldContainerView.alpha = 1
        textFieldContainerView.layer.borderWidth = 0
        textFieldContainerView.backgroundColor = .secondarySystemBackground
        floatingTextField.placeholderColor = .lightGray
        floatingTextField.floatPlaceholderActiveColor = .lightGray
        floatingTextField.textColor = .black
    }

    private func configureActiveState() {
        guard let text = captionLabel.text, text.isEmpty else {
            hideMessage(.error)
            return
        }
        floatingTextField.isUserInteractionEnabled = true
        textFieldContainerView.alpha = 1
        textFieldContainerView.layer.borderWidth = 1
        textFieldContainerView.layer.borderColor = UIColor.lightGray.cgColor
        floatingTextField.lblFloatPlaceholder.textColor = .black
        floatingTextField.placeholderColor = .lightGray
        textFieldContainerView.backgroundColor = .secondarySystemBackground
    }

    private func configureDisabledState() {
        if let text = floatingTextField.text, !text.isEmpty {
            textFieldContainerView.alpha = 1
            textFieldContainerView.layer.borderWidth = 1
            textFieldContainerView.layer.borderColor = UIColor.lightGray.cgColor
        }
        floatingTextField.isUserInteractionEnabled = false
        textFieldContainerView.backgroundColor = UIColor.secondarySystemBackground
        textFieldContainerView.alpha = 0.5
        floatingTextField.floatPlaceholderActiveColor = .lightGray
        floatingTextField.placeholderColor = .lightGray
        floatingTextField.textColor = .black
    }

    private func configureErrorState() {
        floatingTextField.isUserInteractionEnabled = true
        textFieldContainerView.alpha = 1
        textFieldContainerView.backgroundColor = .red.withAlphaComponent(0.1)
        textFieldContainerView.layer.borderWidth = 1
        textFieldContainerView.layer.borderColor = UIColor.red.cgColor
        floatingTextField.floatPlaceholderActiveColor = UIColor.red
        floatingTextField.placeholderColor = UIColor.red
    }

    private func configureCaptionLabel() {
        backgroundView.addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(textFieldContainerView.snp.bottom).offset(4)
        }
    }

    private func configureCloseImage(_ text: String) {
        guard !text.isEmpty, floatingTextField.isFirstResponder else {
            rightImage = nil
            return
        }
    }
    
    private func dropShadow() {
        self.layer.shadowOpacity = 0
    }

    @objc private func doneButtonTapped() {
        floatingTextField.resignFirstResponder()
    }

    @objc private func inputTapped() {
        _ = floatingTextField.becomeFirstResponder()
    }
    
    @objc private func leftImageTaped() {
        self.onLeftImageTap?()
    }
}
