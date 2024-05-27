import UIKit


public enum DSViewModelCornersStyle: Equatable, Hashable {
    
    case `default`
    case zero
    case custom(CGFloat)
    
    
    var rawValue: String {
        switch self {
        case .zero:
            return "zero"
        case .default:
            return "default"
        case .custom(let cornerRadius):
            return "custom_\(cornerRadius)"
        }
    }
}
