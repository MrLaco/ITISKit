import Foundation
import UIKit

public enum DSViewModelWidth: Equatable, Hashable {
    
    case absolute(CGFloat) 
    case estimated(CGFloat) 
    case fractional(CGFloat) 
    
    public var rawValue: String {
        switch self {
        case .absolute(let height):
            return "DSViewModelWidthAbsolute_\(height)"
        case .estimated(let estimation):
            return "DSViewModelWidthEstimated_\(estimation)"
        case .fractional(let fraction):
            return "DSViewModelWidthFractional_\(fraction)"
        }
    }
}

extension DSViewModelWidth {
    
    
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
            return NSCollectionLayoutDimension.absolute(height)
        case .estimated(let estimated):
            return NSCollectionLayoutDimension.estimated(estimated)
        case .fractional(let fractional):
            return NSCollectionLayoutDimension.fractionalWidth(fractional)
        }
    }
}
