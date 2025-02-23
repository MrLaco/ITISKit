import UIKit
import Cartography

extension DSCollectionViewController {

    func addBottomShadow() {
        
        if let bottomShadow = bottomShadow {
            bottomShadow.removeFromSuperview()
        }
        
        bottomShadow = UIView()
        
        guard let bottomShadow = bottomShadow else {
            return
        }
        
        let appearance = DSAppearance.shared.main
        
        bottomShadow.backgroundColor = appearance.primaryView.background
        bottomShadow.clipsToBounds = false
        
        view.addSubview(bottomShadow)
        view.sendSubviewToBack(bottomShadow)
        view.bringSubviewToFront(bottomCollectionViewHolder)
        
        constrain(view, bottomShadow, bottomCollectionViewHolder) { superView, bottomShadow, bottomStackHolderView in
            bottomShadow.left == superView.left
            bottomShadow.right == superView.right
            bottomShadow.bottom == bottomStackHolderView.top + 1
            bottomShadow.height == 1
        }
        
        bottomShadow.alpha = 0
        bottomShadow.dropShadow()
    }

    func addTopShadow() {
        
        if let topShadow = topShadow {
            topShadow.removeFromSuperview()
        }
        
        topShadow = UIView()
        
        guard let topShadow = topShadow else {
            return
        }
        
        let appearance = DSAppearance.shared.main
        topShadow.backgroundColor = appearance.primaryView.background
        topShadow.clipsToBounds = false
        
        view.addSubview(topShadow)
        view.sendSubviewToBack(topShadow)
        view.bringSubviewToFront(topCollectionViewHolder)
        
        constrain(view, topShadow, topCollectionViewHolder) { superView, bottomShadow, topCollectionViewHolder in
            bottomShadow.left == superView.left
            bottomShadow.right == superView.right
            bottomShadow.bottom == topCollectionViewHolder.bottom + 1
            bottomShadow.height == 1
        }
        
        topShadow.alpha = 0
        topShadow.dropShadow()
    }

    func showBottomShadow() {
        UIView.animate(withDuration: 0.3) {
            self.bottomShadow?.alpha = 0.8
        }
    }

    func hideBottomShadow() {
        UIView.animate(withDuration: 0.3) {
            self.bottomShadow?.alpha = 0
        }
    }

    func showTopShadow() {
        UIView.animate(withDuration: 0.3) {
            self.topShadow?.alpha = 0.8
        }
    }
    
    func hideTopShadow() {
        UIView.animate(withDuration: 0.3) {
            self.topShadow?.alpha = 0
        }
    }
}
