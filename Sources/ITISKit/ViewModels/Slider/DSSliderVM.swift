import UIKit

public struct DSSliderVM: DSViewModel, Equatable, Hashable {
    
    public var minimValue: Float
    public var maximValue: Float
    public var value: Float
    public var labelPrefix: String?
    public var labelSuffix: String?
    
    
    @NonEquatable public var didUpdate: ((Float) -> Void)?

    public init(minimValue: Float, maximValue: Float, value: Float) {
        
        self.minimValue = minimValue
        self.maximValue = maximValue
        self.value = value
    }

    public var height: DSViewModelHeight = .estimated(30)
    public var width: DSViewModelWidth = .fractional(1.0)
    public var style: DSViewModelStyle = DSViewModelStyle()
    public var supplementaryItems: [DSSupplementaryView]?
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
    public var type: DSSliderVMType = .default
    public var identifier = "Slider"
    public var accessibilityIdentifier = "Slider"

    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var object: AnyObject?
}

public enum DSSliderVMType {
    case `default`
}

public extension DSSliderVM {
    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSSliderUIView.instanceFromNib()
    }

    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }

    func hash() -> String {
        return hashValue.string()
    }
}
