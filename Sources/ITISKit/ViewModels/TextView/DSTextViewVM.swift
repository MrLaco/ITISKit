import UIKit

public class DSTextViewVM: DSViewModel, Equatable, Hashable {

    public var text: String?

    public init(text: String? = nil) {
        self.text = text
    }
    
    
    @NonEquatable public var didUpdate: ((DSTextViewVM) -> Void)?

    public var height: DSViewModelHeight = .absolute(100)
    public var width: DSViewModelWidth = .fractional(1.0)
    public var style: DSViewModelStyle = DSViewModelStyle()
    public var type: DSTextViewVMType = .default
    public var identifier = "TextView"
    public var accessibilityIdentifier = "TextView"

    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var object: AnyObject?
    
    public static func == (lhs: DSTextViewVM, rhs: DSTextViewVM) -> Bool {
        return lhs.text == rhs.text &&
            lhs.accessibilityIdentifier == rhs.accessibilityIdentifier &&
            lhs.type == rhs.type &&
            lhs._didTap == rhs._didTap &&
            lhs._didUpdate == rhs._didUpdate
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(accessibilityIdentifier)
        hasher.combine(type)
    }
    
    
    public var supplementaryItems: [DSSupplementaryView]?
    
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
}

public enum DSTextViewVMType {
    case `default`
}

public extension DSTextViewVM {

    func reuseIdentifier() -> String {
        return hash()
    }

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSTextViewUIView.instanceFromNib()
    }

    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }

    func hash() -> String {
        return hashValue.string()
    }
}
