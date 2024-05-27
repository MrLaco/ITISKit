import UIKit

extension DSViewModelDisplayStyle {

    func viewInsets() -> UIEdgeInsets {
        
        switch self {
        case .default:
            return .zero
        case .grouped(inSection: let inSection):
            
            if inSection {
                return .zero
            } else {
                return DSAppearance.shared.main.groupMargins.edgeInsets
            }
        }
    }

    func supplementaryViewInsets(section: DSSection, kind: String) -> UIEdgeInsets {
        
        if kind == UICollectionView.elementKindSectionHeader {
            return UIEdgeInsets(top: DSAppearance.shared.main.margins, left: 0, bottom: -5, right: 0)
        } else if kind == UICollectionView.elementKindSectionFooter {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        return .zero
    }
}
