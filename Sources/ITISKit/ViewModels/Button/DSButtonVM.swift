import UIKit

public struct DSButtonVM: DSViewModel, Equatable, Hashable {
    
    public enum DSButtonVMImagePosition {
        case left
        case right
        case rightMargin
        case leftMargin
    }

    public var text: String?
    public var icon: UIImage?
    public var imagePosition: DSButtonVMImagePosition = .left
    public var isEnabled: Bool = true
    public var customFont: DSTextFont?

    public init(title: String? = nil,
                icon: UIImage? = nil,
                type: DSButtonVMType = .default,
                textAlignment: NSTextAlignment = .center,
                didTap handleDidTap: ((DSButtonVM) -> Void)? = nil) {
        
        self.text = title
        self.type = type
        self.icon = icon
        self.textAlignment = textAlignment
        
        self.didTap = { tap in
            if let tap = tap as? DSButtonVM {
                handleDidTap?(tap)
            }
        }
    }

    public init(title: String? = nil,
                sfSymbol: String,
                style: DSSFSymbolConfigStyle = .medium,
                type: DSButtonVMType = .default,
                textAlignment: NSTextAlignment = .center,
                didTap handleDidTap: ((DSButtonVM) -> Void)? = nil) {
        
        self.text = title
        self.type = type
        
        let config = DSSFSymbolConfig.symbolConfig(style: style)
        self.icon = UIImage.symbolImage(with: sfSymbol, configuration: config)
        self.textAlignment = textAlignment
        
        self.didTap = { tap in
            if let tap = tap as? DSButtonVM {
                handleDidTap?(tap)
            }
        }
    }
    
    
    public var height: DSViewModelHeight?
    
    
    public var width: DSViewModelWidth = .fractional(1.0)
    
    
    public var textAlignment: NSTextAlignment = .center
    
    
    public var type: DSButtonVMType = .default
    
    
    public var identifier = "Button"
    
    
    public var accessibilityIdentifier: String = "Button"
    
    
    public var style: DSViewModelStyle = DSViewModelStyle()
    
    
    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    
    
    @NonEquatable public var object: AnyObject?
    
    
    public var supplementaryItems: [DSSupplementaryView]?
    
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
}


public enum DSButtonVMType: Equatable, Hashable {
    
    case `default`
    case link
    case linkWhite
    case linkBlack
    case light
    case secondaryView
    case primaryViewWithBorder
    case cleanWithBorder
    case facebook
    case twitter
    case blur(effect: DSButtonVMBlurEffect, color: DSTextColor)
}

public enum DSButtonVMBlurEffect: Hashable {
    
    case light
    case dark
    
    func style() -> UIBlurEffect.Style {
        switch self {
        case .dark:
            return UIBlurEffect.Style.dark
        case .light:
            return UIBlurEffect.Style.light
        }
    }
}

public extension DSButtonVM {

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height != nil ? height! : .absolute(DSAppearance.shared.main.buttonsHeight)
    }

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSButtonUIView.instanceFromNib()
    }

    func isEqual(to object: DSViewModel) -> Bool {
        guard let object = object as? Self else { return false }
        return self == object
    }

    func hash() -> String {
        return hashValue.string()
    }
}

public extension DSButtonVM {
    
    static func light(text: String, icon: UIImage? = nil) -> DSButtonVM {
        var button = DSButtonVM(title: text, icon: icon)
        button.type = .light
        return button
    }
    
    static func link(text: String, icon: UIImage? = nil) -> DSButtonVM {
        var button = DSButtonVM(title: text, icon: icon)
        button.type = .link
        return button
    }
}
