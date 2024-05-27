import UIKit

public class DSSection: Equatable, Hashable {
    public var viewModels: [DSViewModel] = [DSViewModel]()

    public var header: DSViewModel? {
        didSet {
            
            if header != nil {
                self.insets.top = DSAppearance.shared.main.interItemSpacing
            } else {
                self.insets.top = DSAppearance.shared.main.margins
            }
        }
    }

    public var footer: DSViewModel? {
        didSet {
            
            if footer != nil {
                self.insets.bottom = DSAppearance.shared.main.interItemSpacing
            } else {
                self.insets.bottom = DSAppearance.shared.main.margins
            }
        }
    }

    public var scrollHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?
    
    public func getScrollHandler(for collectionView: DSCollectionView) -> NSCollectionLayoutSectionVisibleItemsInvalidationHandler? {
            return scrollHandler
    }

    public var insets: UIEdgeInsets = .zero
    public var background: DSSectionBackgroundType = .`default`
    public var interItemSpacing: CGFloat = 0
    public var type: DSSectionType = .list
    public var identifier: String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(header?.hash())
        hasher.combine(footer?.hash())
    }
    
    public static func == (lhs: DSSection, rhs: DSSection) -> Bool {
        return
            lhs.insets == rhs.insets &&
            lhs.type == rhs.type &&
            lhs.interItemSpacing == rhs.interItemSpacing
    }
    
    init() {}
}



