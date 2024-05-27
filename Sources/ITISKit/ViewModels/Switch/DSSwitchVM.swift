import UIKit

public struct DSSwitchVM: DSViewModel, Equatable, Hashable {
    
    public var isOn: Bool

    public init(isOn: Bool) {
        self.isOn = isOn
    }
    
    @NonEquatable public var didUpdate: ((Bool) -> Void)?

    public var height: DSViewModelHeight = .absolute(30)
    public var width: DSViewModelWidth = .absolute(52)
    public var style: DSViewModelStyle = DSViewModelStyle()
    public var supplementaryItems: [DSSupplementaryView]?
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
    public var type: DSSwitchVMType = .default
    public var identifier = "Switch"
    public var accessibilityIdentifier = "Switch"

    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var object: AnyObject?
}

public enum DSSwitchVMType {
    case `default`
}

public extension DSSwitchVM {

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSSwitchUIView.instanceFromNib()
    }

    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }
    
    func hash() -> String {
        return hashValue.string()
    }
}
