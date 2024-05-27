import UIKit
import Cartography

extension DSCollectionViewController {
    
    func setUpBottomCollectionView() {
        
        bottomCollectionView = DSCollectionView(position: .bottom)
        bottomCollectionView.view.bounces = false
        bottomCollectionViewHolder = UIView()
        view.addSubview(bottomCollectionViewHolder)
        bottomCollectionViewHolder.addSubview(bottomCollectionView)
        
        addBottomShadow()
        setUpBottomCollectionConstraints()
        bottomContentSizeDidUpdateHandler()
    }

    func setUpBottomCollectionConstraints() {
        
        constrain(bottomCollectionViewHolder, bottomCollectionView, view) { bottomCollectionViewHolder, bottomCollectionView, view in
            
            bottomCollectionViewHolder.left == view.left
            bottomCollectionViewHolder.right == view.right
            
            bottomCollectionView.top == bottomCollectionViewHolder.top
            bottomCollectionView.left == bottomCollectionViewHolder.left
            bottomCollectionView.right == bottomCollectionViewHolder.right
            bottomCollectionView.height == self.view.bounds.height
        }
        
        constrain(bottomCollectionViewHolder, view, bottomCollectionView,
                  replace: bottomCollectionViewHolderHeightConstraintGroup) { bottomCollectionViewHolder, view, bottomCollectionView in
            
            bottomCollectionViewHolder.height == 0
            bottomCollectionViewHolder.bottom == view.bottom
        }
    }

    fileprivate func bottomContentSizeDidUpdateHandler() {
        
        bottomCollectionView.contentSizeDidUpdate = { [weak  self] size in
            if size.height != self?.collectionView.additionalBottomContentSpace {
                self?.adaptBottomContentToNewHeight(height: size.height)
            }
        }
    }
    
    func adaptBottomContentToNewHeight(height: CGFloat) {
        updateCenterContentWithBottomContentHeight(height)
        updateBottomShadowWithBottomContentHeight(height)
        updateBottomContentPosition(height)
    }

    func updateBottomShadowWithCurrentBottomContentHeight() {
        
        let bottomContentHeight = bottomCollectionView.view.contentSize.height
        updateBottomShadowWithBottomContentHeight(bottomContentHeight)
    }

    fileprivate func updateBottomShadowWithBottomContentHeight(_ bottomContentHeight: CGFloat) {
        
        let centerContentHeight = collectionView.view.contentSize.height - bottomContentHeight
        
        if bottomContentHeight > 0 {
            
            let bottomContentHeight = bottomContentHeight + (appearance.groupMargins * 2) + view.safeAreaInsets.bottom + view.safeAreaInsets.top + 20
            
            if centerContentHeight >= (collectionView.view.frame.height - bottomContentHeight) {
                showBottomShadow()
            } else {
                hideBottomShadow()
            }
        } else {
            hideBottomShadow()
        }
    }

    fileprivate func updateCenterContentWithBottomContentHeight(_ bottomContentHeight: CGFloat) {
        collectionView.setBottomAdditionalSpace(space: bottomContentHeight)
    }

    fileprivate func updateBottomContentPosition(_ bottomContentHeight: CGFloat) {
        
        constrain(bottomCollectionViewHolder, view, bottomCollectionView, replace: bottomCollectionViewHolderHeightConstraintGroup) { bottomCollectionViewHolder, view, bottomCollectionView in
            
            bottomCollectionViewHolder.height == bottomContentHeight
            
            if bottomContentHeight > 0 {
                bottomCollectionViewHolder.bottom == view.bottomMargin
            } else {
                bottomCollectionViewHolder.bottom == view.bottom
            }
        }
        
        updateLayout(animated: true)
    }
}
