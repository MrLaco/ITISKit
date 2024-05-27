import UIKit


public struct DSLabelVM: DSViewModel, Equatable, Hashable {
    
    
    public var textComposer: DSTextComposer

    public init(_ type: DSTextType = .body, text: String, alignment: NSTextAlignment = .natural) {
        self.textComposer = DSTextComposer(alignment: alignment)
        self.textComposer.add(type: type, text: text)
    }

    public init(composer: DSTextComposer) {
        self.textComposer = composer
    }

    public var identifier = "TextView"
    public var accessibilityIdentifier: String = "TextView"
    public var style: DSViewModelStyle = DSViewModelStyle()
    public var type: DSTextVMType = .default
    public var height: DSViewModelHeight?
    public var width: DSViewModelWidth?
    
    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var didTapOnMention: ((String) -> Void)?
    @NonEquatable public var didTapOnHashTag: ((String) -> Void)?
    @NonEquatable public var didTapOnUrl: ((URL) -> Void)?
    @NonEquatable public var didTapOnEmail: ((String) -> Void)?
    @NonEquatable public var object: AnyObject?
    
    
    public var supplementaryItems: [DSSupplementaryView]?
    
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
}

public enum DSTextVMType {
    case `default`
}

public extension DSLabelVM {

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width ?? .fractional(1.0)
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height != nil ? height! : textComposer.estimatedHeight(section: section, layoutEnvironment)
    }
    
    func viewRepresentation() -> DSReusableUIView {
        return DSLabelUIView.instanceFromNib()
    }
    
    func isEqual(to model: DSViewModel) -> Bool {
        
        guard let model = model as? Self else {
            return false
        }
        
        return self == model
    }
    
    func hash() -> String {
        return hashValue.string()
    }
}
