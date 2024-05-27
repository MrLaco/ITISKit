import UIKit


public enum DSViewModelBorderStyle: Equatable, Hashable {
    
    case none
    case buttonColor
    case brandColor
    case custom(width: CGFloat, color: UIColor)
    
    var rawValue: String {
        
        switch self {
        case .none:
            return "none"
        case .buttonColor:
            return "buttonColor"
        case .brandColor:
            return "brandColor"
        case .custom(let width, let color):
            return "\(width)\(color.dsDescription)"
        }
    }
}
