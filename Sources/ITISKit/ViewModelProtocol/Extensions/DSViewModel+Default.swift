import UIKit

public extension DSViewModel {

    func reuseIdentifier() -> String {
        
        var additionalIdentifier = ""
        
        if let supplementaryItems = supplementaryItems {
            for item in supplementaryItems {
                additionalIdentifier += item.view.reuseIdentifier()
            }
        }
        
        return String(describing: type(of: self)) + style.displayStyle.rawValue + additionalIdentifier
    }

    func hash() -> String {
        return reuseIdentifier()
    }

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        
        switch section.type {
        case .grid(columns: let columns):
            return .fractional(1.0 / CGFloat(columns))
        case .list:
            return .fractional(1.0)
        case .gallery(type: let type):            
            switch type {
            case .default:
                return .fractional(1.0)
            case .fullWidth:
                return .fractional(1.0)
            }
        }
    }

    func viewRepresentation() -> DSReusableUIView {
        return DefaultReusableUIViewView()
    }
}
