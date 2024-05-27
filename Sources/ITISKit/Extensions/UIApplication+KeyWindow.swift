import UIKit

public extension UIApplication {
    
    func getKeyWindow() -> UIWindow? {
        
        UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
    }
    
    var isRTL: Bool {
        UIApplication.shared.getKeyWindow()?.effectiveUserInterfaceLayoutDirection == .rightToLeft
    }
}
