import UIKit

public protocol DSViewModel {

    func viewRepresentation() -> DSReusableUIView

    var identifier: String {get set}
    var accessibilityIdentifier: String {get set}
    var style: DSViewModelStyle {get set}

    func viewColors(mirrored: Bool) -> DSDesignableViewColors
    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight
    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth
    func isEqual(to object: DSViewModel) -> Bool
    func reuseIdentifier() -> String
    func hash() -> String

    var didTap: ((DSViewModel) -> Void)? {get set}
    var supplementaryItems: [DSSupplementaryView]? {get set}
    var bottomSideView: DSSideView? { get set }
    var topSideView: DSSideView? { get set }
    var leftSideView: DSSideView? { get set }
    var rightSideView: DSSideView? { get set }
    var object: AnyObject? { get set }
}
