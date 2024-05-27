import UIKit

public extension Notification {

    func frameAndDuration() -> (frame: CGRect, duration: Double)? {
        
        guard let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
                return nil
        }
        
        return (frame: keyboardFrame, duration: duration)
    }
}
