import UIKit

public class DSQuantityPickerVM: DSViewModel, Equatable, Hashable {
    
    public var quantity: Int = 1
    public var quantityPluralText: String?
    public var quantitySingularText: String?
    
    
    public init(quantity: Int = 1) {
        self.quantity = quantity
    }

    var rightView: DSView?
    var leftView: DSView?

    public var height: DSViewModelHeight = .absolute(50)
    public var width: DSViewModelWidth = .fractional(1.0)
    public var quantityTextType: DSTextType = .headline
    public var type: DSQuantityPickerVMType = .default
    public var identifier = "QuantityPicker"
    public var accessibilityIdentifier = "QuantityPicker"

    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var quantityDidUpdate: ((Int) -> Void)?
    @NonEquatable public var quantityDidIncrease: ((Int) -> Void)?
    @NonEquatable public var quantityDidDecrease: ((Int) -> Void)?
    @NonEquatable public var object: AnyObject?

    public var supplementaryItems: [DSSupplementaryView]?
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
    
    
    public var style: DSViewModelStyle = DSViewModelStyle()
    
    public static func == (lhs: DSQuantityPickerVM, rhs: DSQuantityPickerVM) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.accessibilityIdentifier == rhs.accessibilityIdentifier &&
        lhs.quantity == rhs.quantity &&
        lhs.type == rhs.type &&
        lhs.leftView == rhs.leftView &&
        lhs.rightView == rhs.rightView
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(quantity)
        hasher.combine(accessibilityIdentifier)
        hasher.combine(type)
        hasher.combine(leftView)
        hasher.combine(rightView)
    }
}

public enum DSQuantityPickerVMType {
    case `default`
}

public extension DSQuantityPickerVM {

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSQuantityPickerUIView.instanceFromNib()
    }

    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }
    
    func hash() -> String {
        return hashValue.string()
    }
}
