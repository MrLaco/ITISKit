import UIKit


public enum DSViewModelHeight: Equatable, Hashable {
    
    case absolute(CGFloat) 
    case estimated(CGFloat) 
    case fractional(CGFloat) 
    
    public var rawValue: String {
        switch self {
        case .absolute(let height):
            return "DSViewModelHeightAbsolute_\(height)"
        case .estimated(let estimation):
            return "DSViewModelHeightEstimated_\(estimation)"
        case .fractional(let fraction):
            return "DSViewModelHeightFractional_\(fraction)"
        }
    }
}

extension DSViewModelHeight {

    public var isEstimated: Bool {
        
        switch self {
        case .estimated(_):
            return true
        default:
            return false
        }
    }

    public var isAbsolute: Bool {
        switch self {
        case .absolute(_):
            return true
        default:
            return false
        }
    }

    public var isFractional: Bool {
        switch self {
        case .fractional(_):
            return true
        default:
            return false
        }
    }

    func absolute() -> CGFloat? {
        switch self {
        case .absolute(let height):
            return height
        case .estimated(_):
            return nil
        case .fractional(_):
            return nil
        }
    }
    
    func dimension() -> NSCollectionLayoutDimension {
                
        switch self {
        case .absolute(let height):
            return NSCollectionLayoutDimension.absolute(height == 0 ? 1 : height)
        case .estimated(let estimated):
            return NSCollectionLayoutDimension.estimated(estimated)
        case .fractional(let fractional):
            return NSCollectionLayoutDimension.fractionalHeight(fractional)
        }
    }
}
