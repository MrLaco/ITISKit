import UIKit
import Cartography

class DSReusableCollectionSupplementaryView: UICollectionReusableView {
    
    var reusableView: DSReusableUIView?
    let constraintGroup = ConstraintGroup()
    var viewModel: DSViewModel?
    var section: DSSection?

    public func setUpWith(viewModel: DSViewModel, section: DSSection, kind: String) {
        
        self.viewModel = viewModel
        self.section = section

        if reusableView == nil {
            reusableView = viewModel.viewRepresentation()
            self.addCustomSubview(view: reusableView?.view, group: constraintGroup)
        }

        setReusableViewStyle(model: viewModel)

        let insets = viewModel.style.displayStyle.supplementaryViewInsets(section: section, kind: kind)
        updateUIEdgeInsets(view: reusableView?.view, insets: insets, group: constraintGroup)
        
        reusableView?.setUpWith(viewModel: viewModel)
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        if let model = self.viewModel, let section = self.section {
            if let heightForHash = DSReusableCollectionViewsHeightManager.shared.heightFor(viewModel: model, in: section) {
                
                var newFrame = layoutAttributes.frame
                newFrame.size.height = heightForHash
                layoutAttributes.frame = newFrame
                return layoutAttributes
            } else {
                let layoutAttributes = update(layoutAttributes)
                let height = layoutAttributes.frame.size.height
                DSReusableCollectionViewsHeightManager.shared.setFor(height: height, viewModel: model, in: section)
                return layoutAttributes
            }
        }
        
        return update(layoutAttributes)
    }
}
