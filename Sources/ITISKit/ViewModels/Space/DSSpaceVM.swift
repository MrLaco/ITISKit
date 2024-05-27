import UIKit


public struct DSSpaceVM: DSViewModel, Equatable, Hashable {

    public init(type: DSSpaceVMType = .default) {
        self.type = type
    }

    public var type: DSSpaceVMType = .default
    public var identifier = "Space"
    public var accessibilityIdentifier = "Space"
    public var style: DSViewModelStyle = DSViewModelStyle()

    @NonEquatable public var didTap: ((DSViewModel) -> Void)?

    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    public var supplementaryItems: [DSSupplementaryView]?
    
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
    
    @NonEquatable public var object: AnyObject?
}


public enum DSSpaceVMType: Equatable, Hashable {
    
    case `default` 
    case custom(CGFloat)

    var rawValue: String {
        switch self {
        case .default:
            return "Default"
        case .custom(let height):
            return "Custom\(height)"
        }
    }
}

public extension DSSpaceVM {

    func reuseIdentifier() -> String {
        return String(describing: Swift.type(of: self)) + style.displayStyle.rawValue + type.rawValue
    }
    
    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        
        switch type {
        case .default:
            return .absolute(DSAppearance.shared.main.margins)
        case .custom(let space):
            return .absolute(space)
        }
    }
    
    func viewRepresentation() -> DSReusableUIView {
        return DSSpaceUIView.instanceFromNib()
    }
    
    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }
    
    func hash() -> String {
        return hashValue.string()
    }
}
