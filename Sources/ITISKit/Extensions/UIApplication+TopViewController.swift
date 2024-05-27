import UIKit

extension UIViewController {
    
    func topMostViewController() -> UIViewController? {
        
        if self.presentedViewController == nil {
            
            if let navigation = self as? UINavigationController {
                return navigation.visibleViewController?.topMostViewController() ?? nil
            }
            
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? nil
        }
        
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        
        let controller = UIApplication.shared.getKeyWindow()?.rootViewController?.topMostViewController()
        
        return controller
    }
}
