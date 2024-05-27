import UIKit

public struct DSActionVM: DSViewModel, Equatable, Hashable {
    public var height: DSViewModelHeight?
    public var width: DSViewModelWidth = .fractional(1.0)
    public var leftViewPosition: DSViewPosition = .center
    public var expandImageOverBoundsForGroups: Bool = true

    var text: DSTextComposer
    var rightView: DSView?
    var leftView: DSView?
    var topImage: DSImageContent?
    var topImageHeight: DSImageHeight = .zero

    public var zeroSpaceToTopImage: Bool = false

    var topImageContentMode: DSImageContentMode = .scaleAspectFill

    public init(title: String,
                subtitle: String? = nil,
                leftSFSymbol: String? = nil,
                arrow: Bool = true,
                didTap handleDidTap: ((DSActionVM) -> Void)? = nil) {
        
        let text = DSTextComposer()
        
        
        text.add(type: .headline, text: title)
        
        
        if let subtitle = subtitle {
            text.add(type: .subheadline, text: subtitle)
        }
        
        
        if let leftSFSymbol = leftSFSymbol {
            
            let image = DSImage(content: .sfSymbol(name: leftSFSymbol, style: .medium),
                                displayStyle: .default,
                                tintColor: .text(.headline),
                                contentMode: .scaleAspectFit)
            
            self.leftView = DSView(.image(image))
        }
        
        
        if arrow {
            
            let arrow = DSImage(content: .sfSymbol(name: "chevron.right", style: .medium),
                                size: .size(CGSize(width: 12, height: 23)),
                                tintColor: .text(.subheadline))
            
            
            self.rightView = DSView(.image(arrow))
        }
        
        self.text = text
        self.didTap = { tap in
            if let tap = tap as? DSActionVM {
                handleDidTap?(tap)
            }
        }
    }

    public init(composer: DSTextComposer) {
        self.text = composer
    }

    public var identifier = "Action"
    public var accessibilityIdentifier = "Action"
    public var style: DSViewModelStyle = DSViewModelStyle(displayStyle: .grouped(inSection: false))
    
    
    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var object: AnyObject?
    
    
    public var supplementaryItems: [DSSupplementaryView]?
    
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
}

public extension DSActionVM {

    func reuseIdentifier() -> String {
        
        var id = topImageHeight.rawValue
        id += topImage?.rawValue ?? "TopImageNone"
        id += rightView?.content.rawValue ?? "RightViewNone"
        id += leftView?.content.rawValue ?? "LeftViewNone"
        id += style.displayStyle.rawValue
        id += width.rawValue
        id += height?.rawValue ?? "Height"
        return String(describing: type(of: self)) + id
    }
    
    
    func estimatedHeight() -> CGFloat {
        
        var additionalHeight: CGFloat = 0
        
        switch self.topImageHeight {
        case .equalTo(let imageHeight):
            additionalHeight = imageHeight
        case .zero:
            additionalHeight = 0
        case .unknown:
            additionalHeight = 0
        }
        
        switch style.displayStyle {
        case .default:
            return 30 + additionalHeight
        case .grouped(inSection: _):
            return 55 + additionalHeight
        }
    }

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height != nil ? height! : .estimated(estimatedHeight())
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSActionUIView.instanceFromNib()
    }

    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }

    func hash() -> String {
        return hashValue.string()
    }
}
