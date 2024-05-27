import UIKit

public struct DSPageVM: DSViewModel, Equatable, Hashable {

    let viewModels: [DSViewModel]

    public var contentInsets: UIEdgeInsets = .zero
    public var height: DSViewModelHeight = .fractional(1.0)

    public init(viewModels: [DSViewModel], contentInsets: UIEdgeInsets = .zero) {
        self.viewModels = viewModels
    }

    public var type: DSPageVMType = .default
    public var identifier = "Page"
    public var accessibilityIdentifier = "Page"
    public var style: DSViewModelStyle = DSViewModelStyle()

    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var object: AnyObject?

    public static func == (lhs: DSPageVM, rhs: DSPageVM) -> Bool {
        return false
    }

    public func hash(into hasher: inout Hasher) {
        for model in viewModels {
            hasher.combine(model.hash())
        }
    }

    public var supplementaryItems: [DSSupplementaryView]?
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
}

public enum DSPageVMType {
    case `default`
}

public extension DSPageVM {
    
    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height
    }
    
    func viewRepresentation() -> DSReusableUIView {
        return DSPageUIView.instanceFromNib()
    }
    
    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }
    
    func hash() -> String {
        return hashValue.string()
    }
}
