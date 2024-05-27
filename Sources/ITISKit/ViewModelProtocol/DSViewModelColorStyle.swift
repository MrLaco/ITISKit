import UIKit

public enum DSViewModelColorStyle: Equatable, Hashable {
    
    case `default`
    case primary
    case secondary
    case custom(DSDesignableViewColors)
    
    var rawValue: String {
        switch self {
        case .primary:
            return "primary"
        case .secondary:
            return "secondary"
        case .custom(_):
            return "custom"
        case .default:
            return "default"
        }
    }
}
