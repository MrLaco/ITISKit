import UIKit

public extension DSBaseViewController {
    
    func setUpMessageHud() {

        if let navigationController = self.navigationController {
            
            for view in navigationController.view.subviews where view.tag == messageHUDTag {
                
                guard let view = view as? DSMessageHUD else {
                    return
                }
                
                messageHud = view
            }

            if messageHud == nil {
                messageHud = DSMessageHUD(onView: navigationController.view)
            }
        } else {
            messageHud = DSMessageHUD(onView: self.view)
        }
    }
    
    func show(message: String, type: DSMessageType = .default, timeOut: Double = 1.5, icon: UIImage? = nil, completion: (() -> Void)? = nil) {
        
        if let successHud = self.messageHud {
            successHud.show(message: message,
                            type: type,
                            timeOut: timeOut,
                            icon: icon,
                            completion: completion)
        }
    }
}
