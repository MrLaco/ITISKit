import UIKit

extension UIEdgeInsets {
    
    var directionalEdgeInsets: NSDirectionalEdgeInsets {
        
        return NSDirectionalEdgeInsets(top: top,
                                       leading: left,
                                       bottom: bottom,
                                       trailing: right)
    }
    
    var zeroLeftRightDirectionalEdgeInsets: NSDirectionalEdgeInsets {
        
        return NSDirectionalEdgeInsets(top: top,
                                       leading: 0,
                                       bottom: bottom,
                                       trailing: 0)
    }
    
    var groupedGridDirectionalEdgeInsets: NSDirectionalEdgeInsets {
        
        return NSDirectionalEdgeInsets(top: top,
                                       leading: left,
                                       bottom: bottom,
                                       trailing: right)
    }
}
