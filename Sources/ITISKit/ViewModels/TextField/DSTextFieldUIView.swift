import UIKit

final class DSTextFieldUIView: UIView, DSReusableUIView {

    @IBOutlet weak var messageLabelContainerView: UIView!
    @IBOutlet weak var messageLabelGradientView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldHolder: UIView!
    @IBOutlet weak var textFieldLeftSpace: NSLayoutConstraint!
    
    private var showHideButton: UIButton?
    
    private lazy var messageLabelGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        return gradient
    }()
    
    
    var viewModel: DSTextFieldVM?
    var appearance = DSAppearance.shared.main

    public var view: UIView { self }

    public func setUpWith(viewModel: DSViewModel) {
        
        guard let viewModel = viewModel as? DSTextFieldVM else {
            return
        }
        viewModel.textField = textField
        
        self.viewModel = viewModel
        update(viewModel: viewModel)
        updateLayout(viewModel: viewModel)
    }

    func update(viewModel: DSTextFieldVM) {
        
        
        handleTextFieldValidation()
        
        
        textField.placeholder = viewModel.placeholder
        textField.text = viewModel.text
        textField.isSecureTextEntry = viewModel.isSecured
        textField.textAlignment = viewModel.textAlignment
        
        if viewModel.didTap != nil {
            textField.isUserInteractionEnabled = false
        } else {
            textField.isUserInteractionEnabled = true
        }
        
        
        validate()
    }

    func updateLayout(viewModel: DSTextFieldVM) {
        
        let colors = viewModel.viewColors()

        textFieldHolder.backgroundColor = colors.textField.background
        textFieldHolder.layer.cornerRadius = colors.cornerRadius
        updateTextFieldHolderBorder()

        textField.font = appearance.fonts.body.withSize(14)
        textField.textColor = colors.textField.text
        textField.keyboardType = viewModel.keyboardType
        textField.textContentType = viewModel.textContentType
        textField.returnKeyType = viewModel.returnKeyType
        textField.autocapitalizationType = viewModel.autocapitalizationType
        textField.autocorrectionType = .no

        let placeholderText = textField.placeholder != nil ? textField.placeholder! : viewModel.placeholder
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: colors.textField.placeHolder])

        if viewModel.isSecured {
            setupShowHideButton()
        } else {
            setupClearButton()
        }

        updateLeftView()

        messageLabelContainerView.backgroundColor = colors.textField.background
        messageLabelGradient.colors = [colors.textField.background.withAlphaComponent(0.0).cgColor, colors.textField.background.withAlphaComponent(1.0).cgColor]
    }
    
    func updateLeftView() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        let colors = viewModel.viewColors()
        
        
        if let sfSymbolName = viewModel.leftSFSymbolName {
            
            let symbol = DSImage(content: .sfSymbol(name: sfSymbolName, style: .medium),
                                 displayStyle: .default,
                                 size: .size(CGSize(width: 22, height: 22)),
                                 tintColor: viewModel.text?.count ?? 0 > 0 ? .text(.headline) : .text(.subheadline),
                                 contentMode: .scaleAspectFit)
            
            textField.leftView = symbol.view(colors).subViewWith(insets: .init(top: 0, left: 0, bottom: 0, right: 8))
            textField.leftViewMode = .always
            textFieldLeftSpace.constant = appearance.groupMargins
        } else {
            textFieldLeftSpace.constant = appearance.groupMargins
        }
    }

    func validate(delay: TimeInterval = 0.0) {
        
        guard let viewModel = viewModel else {
            return
        }
        
        
        let text = textField.text
        viewModel.text = text
        viewModel.didUpdate?(viewModel)
        
        
        viewModel.isValid(text: text, validateEmptyTextField: viewModel.validateEmptyTextField) { [self] isValid in
            
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            if isValid {
                self.validStyle()
            } else {
                self.perform(#selector(invalidStyle), with: isValid, afterDelay: delay)
            }
        }
    }

    func handleTextFieldValidation() {
        
        guard let viewModel = viewModel else {
            return
        }
    
        viewModel.validateTextField = {
            
            let text = self.textField.text
            
            
            viewModel.isValid(text: text, validateEmptyTextField: false) { [self] isValid in
                if isValid {
                    self.validStyle()
                } else {
                    self.viewModel?.validateEmptyTextField = false
                    self.invalidStyle()
                }
            }
        }
    }
    
    
    func validStyle() {
        updateTextFieldHolderBorder()
    }
    
    
    @objc func invalidStyle() {
        updateTextFieldHolderBorder(customColor: UIColor.systemRed)
    }
    
    func updateTextFieldHolderBorder(customColor: UIColor? = nil) {
        guard let viewModel = viewModel else {
            return
        }
        
        textFieldHolder.configureBorder(viewModel.borderStyle, viewColors: viewModel.viewColors())
        
        if let customColor = customColor {
            textFieldHolder.layer.borderWidth = max(textFieldHolder.layer.borderWidth, 1.0)
            textFieldHolder.layer.borderColor = customColor.cgColor
        }
    }
    
    
    func hideInvalidMessage() {
        UIView.animate(withDuration: 0.4) {
            self.messageLabelContainerView.alpha = 0.0
        }
    }
    
    
    func showInvalidMessageIfNeed() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        DispatchQueue.main.after(0.5) {
            viewModel.isValid(text: self.textField.text,
                              validateEmptyTextField: viewModel.validateEmptyTextField) { [self] isValid in
                if !isValid {
                    invalidMessageStyle()
                }
            }
        }
    }
    
    
    @objc func invalidMessageStyle() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        if let text = viewModel.errorPlaceHolderText {
            
            let colors = viewModel.viewColors(mirrored: true)
            
            messageLabel.text = text
            messageLabel.textColor = colors.text.subheadline
            messageLabel.font = appearance.fonts.caption2.withSize(14)
            
            UIView.animate(withDuration: 0.4) {
                self.messageLabelContainerView.alpha = 1.0
            }
        }
        
        invalidStyle()
    }
    
    @IBAction func editingBegin(_ sender: Any) {
        hideInvalidMessage()
    }
    
    @IBAction func editingEnd(_ sender: Any) {
        showInvalidMessageIfNeed()
    }
    
    @IBAction func editingChange(_ sender: Any) {
        validate(delay: 5.0)
        updateLeftView()
    }
    
    @IBAction func messageLabelContainerViewTapped(_ sender: Any) {
        textField.becomeFirstResponder()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        messageLabelGradientView.layer.addSublayer(messageLabelGradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        messageLabelGradient.frame = messageLabelGradientView.bounds
    }
    
    
    func setupShowHideButton() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        let colors = viewModel.viewColors()
        
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = colors.button.background
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showHideText(_:)), for: .touchUpInside)
        
        showHideButton = button
        
        
        textField.rightView = showHideButton?.subViewWith(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: appearance.interItemSpacing))
        textField.rightViewMode = .always
    }
    
    
    func setupClearButton() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        let colors = viewModel.viewColors()
        
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = colors.button.background
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(clear(_:)), for: .touchUpInside)
        
        
        textField.rightView = button.subViewWith(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: appearance.interItemSpacing))
        textField.rightViewMode = .whileEditing
    }
    
    
    
    @objc func clear(_ sender : AnyObject) {
        textField.text = ""
        textField.sendActions(for: .editingChanged)
    }
    
    @objc func showHideText(_ sender : AnyObject) {
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
            showHideButton?.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showHideButton?.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    class func instanceFromNib() -> DSTextFieldUIView {
        let view: DSTextFieldUIView = initFromNib()
        return view
    }
}


extension DSTextFieldUIView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let viewModel = viewModel else {
            return true
        }
        
        return viewModel.shouldReturn?(viewModel) ?? true
    }
}
