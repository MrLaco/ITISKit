import UIKit


public enum DSViewModelDisplayStyle: Equatable, Hashable {
    
    case `default` 
    case grouped(inSection: Bool) 
    
    
    var rawValue: String {
        switch self {
        case .default:
            return "Default"
        case .grouped(inSection: let inSection):
            if inSection {
                return "SectionGrouped"
            } else {
                return "Grouped"
            }
        }
    }
}
