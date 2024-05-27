import UIKit

public class DSTextFieldVM: DSViewModel, Equatable, Hashable {
    
    
    public var placeholder: String
    public var text: String?
    public var textAlignment: NSTextAlignment = .left
    
    internal weak var textField: UITextField?

    let validator = DSStringValidator()

    public init(text: String? = nil, placeholder: String) {
        self.text = text
        self.placeholder = placeholder
    }
    
    
    public var height: DSViewModelHeight?
    
    
    public var leftSFSymbolName: String?
    
    
    public var identifier = "TextField"
    
    
    public var accessibilityIdentifier: String = "TextField"
    
    
    public var borderStyle: DSViewModelBorderStyle = .none
    
    
    public var style: DSViewModelStyle = DSViewModelStyle() {
        didSet {
            borderStyle = style.borderStyle
            style.borderStyle = .none
        }
    }
    
    
    public var errorPlaceHolderText: String?
    
    
    public var validateMinimumLength: Int = 0
    
    
    public var validateMaximumLength: Int = 240
    
    
    public var keyboardType: UIKeyboardType = .default
    
    
    public var textContentType: UITextContentType? = nil
    
    
    public var returnKeyType: UIReturnKeyType = .default
    
    
    public var autocapitalizationType: UITextAutocapitalizationType = .none
    
    
    public var validationPattern: String = patternLetters
    
    
    public var validateEmptyTextField: Bool = true
    
    
    public var isSecured: Bool = false
    
    
    public var type: TextFieldViewModelType = .default
    
    
    public var isFirstResponder: Bool {
        get {
            return textField?.isFirstResponder ?? false
        }
        set {
            if newValue {
                textField?.becomeFirstResponder()
            } else {
                textField?.resignFirstResponder()
            }
        }
    }
    
    
    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    
    
    @NonEquatable public var didUpdate: ((DSTextFieldVM) -> Void)?
    
    
    @NonEquatable public var shouldReturn: ((DSTextFieldVM) -> Bool)?
    
    
    @NonEquatable public var handleValidation: ((String?) -> Bool)?
    
    
    @NonEquatable public var validateTextField: (() -> Void)?
    
    public static func == (lhs: DSTextFieldVM, rhs: DSTextFieldVM) -> Bool {
        return lhs.placeholder == rhs.placeholder &&
            lhs.identifier == rhs.identifier &&
            lhs.text == rhs.text &&
            lhs.accessibilityIdentifier == rhs.accessibilityIdentifier &&
            lhs.errorPlaceHolderText == rhs.errorPlaceHolderText &&
            lhs.validateMinimumLength == rhs.validateMinimumLength &&
            lhs.validateMaximumLength == rhs.validateMaximumLength &&
            lhs.validationPattern == rhs.validationPattern &&
            lhs.validateEmptyTextField == rhs.validateEmptyTextField &&
            lhs.isSecured == rhs.isSecured &&
            lhs.type == rhs.type &&
            lhs.keyboardType == rhs.keyboardType &&
            lhs.textContentType == rhs.textContentType &&
            lhs.returnKeyType == rhs.returnKeyType &&
            lhs._didTap == rhs._didTap &&
            lhs._didUpdate == rhs._didUpdate &&
            lhs._handleValidation == rhs._handleValidation
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(placeholder)
        hasher.combine(identifier)
        hasher.combine(text)
        hasher.combine(keyboardType)
        hasher.combine(textContentType)
        hasher.combine(returnKeyType)
        hasher.combine(accessibilityIdentifier)
        hasher.combine(errorPlaceHolderText)
        hasher.combine(validateMinimumLength)
        hasher.combine(validateMaximumLength)
        hasher.combine(validationPattern)
        hasher.combine(isSecured)
        hasher.combine(type)
        hasher.combine(validateEmptyTextField)
    }
    
    
    public var supplementaryItems: [DSSupplementaryView]?
    
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
    
    
    @NonEquatable public var object: AnyObject?
}


public enum TextFieldViewModelType: Equatable, Hashable {
    case `default`
}

public extension DSTextFieldVM {
    
    
    func reuseIdentifier() -> String {
        return hash()
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight  {
        
        if let height = height {
            return height
        }
        
        switch type {
        case .default:
            return .absolute(43)
        }
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSTextFieldUIView.instanceFromNib()
    }

    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }
    
    func hash() -> String {
        return hashValue.string()
    }
}
