import UIKit
import Cartography

class DSReusableCollectionViewCell: UICollectionViewCell {

    var reusableUIView: UIView?
    var reusableView: DSReusableUIView?
    var bottomSideView: DSReusableUIView?
    var topSideView: DSReusableUIView?
    var leftSideView: DSReusableUIView?
    var rightSideView: DSReusableUIView?
    var supplementaryReusableViews: [DSReusableUIView]?
    let constraintGroup = ConstraintGroup()
    var viewModel: DSViewModel?
    var section: DSSection?
    var viewIndex: Int?
    
    public func setUpWith(viewModel: DSViewModel, section: DSSection, viewIndex: Int) {
        self.viewModel = viewModel
        self.viewModel?.prepareToDisplay()
        self.viewIndex = viewIndex
        self.section = section
        
        guard let viewModel = self.viewModel else {
            return
        }
        
        if reusableView == nil {
            
            reusableView = viewModel.viewRepresentation()
            
            if let view = reusableView?.view {
                
                let result = viewModel.viewRepresentationWithSideViews(with: view)
                reusableUIView = result.view
                
                leftSideView = result.leftSideView
                rightSideView = result.rightSideView
                topSideView = result.topSideView
                bottomSideView = result.bottomSideView
            }
            
            contentView.addCustomSubview(view: reusableUIView, group: constraintGroup)
            setUpSupplementaryViewsFor(viewModel)
        }
        
        
        setReusableViewStyle(model: viewModel)
        
        
        let insets = viewModel.style.displayStyle.viewInsets()
        
        
        contentView.updateUIEdgeInsets(view: reusableUIView, insets: insets, group: constraintGroup)
        
        setSupplementaryViewsViewModelIfNeed(viewModel)
        
        
        reusableView?.setUpWith(viewModel: viewModel)
        
        if let vm = viewModel.leftSideView?.viewModel {
            leftSideView?.setUpWith(viewModel: vm)
        }
        
        if let vm = viewModel.topSideView?.viewModel {
            topSideView?.setUpWith(viewModel: vm)
        }
        
        if let vm = viewModel.rightSideView?.viewModel {
            rightSideView?.setUpWith(viewModel: vm)
        }
        
        if let vm = viewModel.bottomSideView?.viewModel {
            bottomSideView?.setUpWith(viewModel: vm)
        }
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        if let model = self.viewModel, let section = self.section {
            
            let width = model.width(nil, section: section)
            let height = model.height(nil, section: section)
            
            if width.isAbsolute && height.isAbsolute {
                
                return absoluteWidthAbsoluteHeight(layoutAttributes, width, height)
                
            } else if width.isAbsolute && height.isEstimated {
                
                return absoluteWidthEstimatedHeight(model, section, layoutAttributes, width)
                
            } else if width.isEstimated && height.isAbsolute {
                
                return estimatedWidthAbsoluteHeight(model, section, layoutAttributes, height)
                
            } else if width.isEstimated && height.isEstimated {
                
                return estimatedWidthEstimatedHeight(model, section, layoutAttributes)
                
            } else {
                
                return defaultLayout(model, section, layoutAttributes)
            }
        }
        
        return update(layoutAttributes)
    }

    fileprivate func estimatedWidthAbsoluteHeight(_ model: DSViewModel,
                                                  _ section: DSSection,
                                                  _ layoutAttributes: UICollectionViewLayoutAttributes, _
                                                    height: DSViewModelHeight) -> UICollectionViewLayoutAttributes {

        if let width = DSReusableCollectionViewsHeightManager.shared.widthFor(viewModel: model, in: section) {
            
            var newFrame = layoutAttributes.frame
            newFrame.size.width = width
            layoutAttributes.frame = newFrame
            return layoutAttributes
            
        } else {
            
            let layoutAttributes = update(layoutAttributes, absoluteHeight: height.dimension().dimension)
            let width = layoutAttributes.frame.size.width
            
            DSReusableCollectionViewsHeightManager.shared.setFor(width: width, viewModel: model, in: section)
            return layoutAttributes
        }
    }

    fileprivate func absoluteWidthEstimatedHeight(_ model: DSViewModel,
                                                  _ section: DSSection,
                                                  _ layoutAttributes: UICollectionViewLayoutAttributes, _
                                                    width: DSViewModelWidth) -> UICollectionViewLayoutAttributes {
        
        if let height = DSReusableCollectionViewsHeightManager.shared.heightFor(viewModel: model, in: section) {
            var newFrame = layoutAttributes.frame
            newFrame.size.height = height
            layoutAttributes.frame = newFrame
            return layoutAttributes
        } else {
            let layoutAttributes = update(layoutAttributes, absoluteWidth: width.dimension().dimension)
            let height = layoutAttributes.frame.size.height
            DSReusableCollectionViewsHeightManager.shared.setFor(height: height, viewModel: model, in: section)
            return layoutAttributes
        }
    }

    fileprivate func estimatedWidthEstimatedHeight(_ model: DSViewModel,
                                                   _ section: DSSection,
                                                   _ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if let width = DSReusableCollectionViewsHeightManager.shared.widthFor(viewModel: model, in: section),
           let height = DSReusableCollectionViewsHeightManager.shared.heightFor(viewModel: model, in: section) {
            
            var newFrame = layoutAttributes.frame
            newFrame.size.width = width
            newFrame.size.height = height
            layoutAttributes.frame = newFrame
            return layoutAttributes
        } else {
            let layoutAttributes = updateEstimatedWidthAndHeight(layoutAttributes)
            let width = layoutAttributes.frame.size.width
            let height = layoutAttributes.frame.size.height
            
            DSReusableCollectionViewsHeightManager.shared.setFor(width: width, viewModel: model, in: section)
            
            DSReusableCollectionViewsHeightManager.shared.setFor(height: height, viewModel: model, in: section)
            
            return layoutAttributes
        }
    }

    fileprivate func absoluteWidthAbsoluteHeight(_ layoutAttributes: UICollectionViewLayoutAttributes, _ width: DSViewModelWidth, _ height: DSViewModelHeight) -> UICollectionViewLayoutAttributes {
        
        var newFrame = layoutAttributes.frame
        newFrame.size.width = width.dimension().dimension
        newFrame.size.height = height.dimension().dimension
        layoutAttributes.frame = newFrame
        
        return layoutAttributes
    }

    fileprivate func defaultLayout(_ model: DSViewModel, _ section: DSSection, _ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        if let height = DSReusableCollectionViewsHeightManager.shared.heightFor(viewModel: model, in: section) {
            var newFrame = layoutAttributes.frame
            newFrame.size.height = height
            layoutAttributes.frame = newFrame
            return layoutAttributes
        } else {
            let layoutAttributes = update(layoutAttributes)
            let height = layoutAttributes.frame.size.height
            DSReusableCollectionViewsHeightManager.shared.setFor(height: height, viewModel: model, in: section)
            return layoutAttributes
        }
    }
}
