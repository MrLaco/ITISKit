import UIKit

extension UIEdgeInsets {

    func add(_ number: CGFloat) -> UIEdgeInsets {
        var insets = self
        insets.top += number
        insets.bottom += number
        insets.left += number
        insets.right += number
        return insets
    }
}
