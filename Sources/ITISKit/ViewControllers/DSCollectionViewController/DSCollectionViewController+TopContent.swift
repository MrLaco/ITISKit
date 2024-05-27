import UIKit
import Cartography

extension DSCollectionViewController {

    func setUpTopCollectionView() {
        
        topCollectionView = DSCollectionView(position: .top)
        topCollectionView.view.bounces = false
        topCollectionViewHolder = UIView()
        topCollectionViewHolder.clipsToBounds = true
        view.addSubview(topCollectionViewHolder)
        
        topCollectionViewHolder.addSubview(topCollectionView)
        addTopShadow()
        setUpTopCollectionConstraints()
        topContentSizeDidUpdateHandler()
    }
    
    fileprivate func setUpTopCollectionConstraints() {
        
        constrain(topCollectionViewHolder, topCollectionView, view) { topCollectionViewHolder, topCollectionView, view in
            
            topCollectionViewHolder.left == view.left
            topCollectionViewHolder.right == view.right
            
            topCollectionView.left == topCollectionViewHolder.left
            topCollectionView.right == topCollectionViewHolder.right
            topCollectionView.height == self.view.bounds.height
            topCollectionView.top == topCollectionViewHolder.top
        }
        
        constrain(topCollectionViewHolder, view, replace: topCollectionViewHolderHeightConstraintGroup) { topCollectionViewHolder, view in
            topCollectionViewHolder.height == 0
            topCollectionViewHolder.top == view.top
        }
    }

    fileprivate func topContentSizeDidUpdateHandler() {
        
        topCollectionView.contentSizeDidUpdate = { [weak  self] size in
            if size.height != self?.collectionView.additionalTopContentSpace {
                self?.adaptTopContentToNewHeight(height: size.height)
            }
        }
    }

    func adaptTopContentToNewHeight(height: CGFloat) {
        
        self.updateCenterContentWithTopContentHeight(height)
        self.updateTopContentHeight(height)
        self.updateTopShadowWithBottomContentHeight(height)
    }

    func updateTopContentHeight(_ height: CGFloat) {
        
        constrain(topCollectionViewHolder, view, replace: topCollectionViewHolderHeightConstraintGroup) { topCollectionViewHolder, view in
            
            topCollectionViewHolder.height == height
            
            if height > 0 {
                topCollectionViewHolder.top == view.topMargin
            } else {
                topCollectionViewHolder.top == view.top
            }
        }
        
        self.updateLayout(animated: true)
    }

    fileprivate func updateTopShadowWithBottomContentHeight(_ topContentHeight: CGFloat) {
        
        if topContentHeight > 0 {
            showTopShadow()
        } else {
            hideTopShadow()
        }
    }
    
    fileprivate func updateCenterContentWithTopContentHeight(_ topContentSize: CGFloat) {
        collectionView.setTopAdditionalSpace(space: topContentSize)
    }
}
