import UIKit
import Cartography

extension UIView {
        
    func subViewWith(insets: UIEdgeInsets) -> UIView {
        
        let holderView = UIView()
        holderView.addSubview(self)
        
        constrain(self, holderView) { view, holderView in
            view.left == holderView.left + insets.left
            view.top == holderView.top + insets.top
            view.bottom == holderView.bottom - insets.bottom
            view.right == holderView.right - insets.right
        }
        
        return holderView
    }
}
