import Foundation
import UIKit

class DSImageCache: NSObject, NSDiscardableContent {

    public var image: UIImage?

    func beginContentAccess() -> Bool {
        return true
    }

    func endContentAccess() {}

    func discardContentIfPossible() {}

    func isContentDiscarded() -> Bool {
        return false
    }
}

public class DSCacheManager {
    
    let mapImageCache = NSCache<NSString, DSImageCache>()
    
    public static let shared = DSCacheManager()
    
    public init() {
        mapImageCache.countLimit = 200
        mapImageCache.totalCostLimit = 0
    }
}
