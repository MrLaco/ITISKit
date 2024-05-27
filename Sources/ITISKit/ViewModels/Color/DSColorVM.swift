import UIKit

public struct DSColorVM: DSViewModel, Equatable, Hashable {
    
    public var color: UIColor?
    
    
    public init(color: UIColor) {
        self.color = color
    }
    
    
    public var height: DSViewModelHeight = .absolute(100)
    public var width: DSViewModelWidth = .fractional(1.0)
    public var style: DSViewModelStyle = DSViewModelStyle()
    public var supplementaryItems: [DSSupplementaryView]?
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
    public var type: DSColorVMType = .default
    public var identifier = "Color"
    public var accessibilityIdentifier = "Color"

    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var object: AnyObject?
}

public enum DSColorVMType {
    case `default`
}

public extension DSColorVM {

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSColorUIView.instanceFromNib()
    }

    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }
    
    func hash() -> String {
        return hashValue.string()
    }
}
