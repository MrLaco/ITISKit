import UIKit

public enum DSViewModelShadowStyle: Equatable, Hashable {
    
    case none
    case small
    case light
    
    var rawValue: String {
        
        switch self {
        case .none:
            return "none"
        case .small:
            return "small"
        case .light:
            return "light"
        }
    }
}
