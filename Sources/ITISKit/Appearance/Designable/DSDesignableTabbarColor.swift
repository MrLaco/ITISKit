import UIKit


public struct DSDesignableTabbarColor {

    public init(barTint: UIColor,
                itemTint: UIColor,
                unselectedItemTint: UIColor,
                badge: UIColor,
                translucent: Bool = false) {
        
        self.barTint = barTint
        self.itemTint = itemTint
        self.unselectedItemTint = unselectedItemTint
        self.badge = badge
        self.translucent = translucent
    }

    public var barTint: UIColor
    public var itemTint: UIColor
    public var unselectedItemTint: UIColor
    public var badge: UIColor
    public var translucent: Bool
}
