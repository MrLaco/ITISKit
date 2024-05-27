import UIKit

public enum DSImageContentMode: Equatable, Hashable {
    
    case scaleAspectFit 
    case scaleAspectFill 
    
    public var rawValue: String {
        switch self {
        case .scaleAspectFit:
            return "ScaleAspectFit"
        case .scaleAspectFill:
            return "ScaleAspectFill"
        }
    }
}

extension UIImageView {
    
    func setImageContentMode(_ contentMode: DSImageContentMode) {

        switch contentMode {
        case .scaleAspectFill:
            self.contentMode = .scaleAspectFill
        case .scaleAspectFit:
            self.contentMode = .scaleAspectFit
        }
    }
}
