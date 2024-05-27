import UIKit

public enum DSImageHeight: Equatable, Hashable {
    
    case equalTo(CGFloat)
    case zero
    case unknown
    
    var rawValue: String {
        switch self {
        case .equalTo(let height):
            return "ImageHeight\(height)"
        case .zero:
            return "ImageHeightZero"
        case .unknown:
            return "ImageHeightUnknown"
        }
    }
}
