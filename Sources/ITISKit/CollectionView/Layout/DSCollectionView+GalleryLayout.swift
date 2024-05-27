import UIKit

extension DSCollectionView {

    func galleryLayout(section: DSGallerySection, _ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        
        var behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
        var subitems = [NSCollectionLayoutItem]()
        var groupHeight: NSCollectionLayoutDimension = .estimated(40)
        var groupWidth: NSCollectionLayoutDimension = .absolute(layoutEnvironment.container.contentSize.width)

        for model in section.viewModels {
            let width = model.width(layoutEnvironment, section: section)
            let height = model.height(layoutEnvironment, section: section)
            let itemSize = NSCollectionLayoutSize(widthDimension: width.dimension(), heightDimension: height.dimension())
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            subitems.append(item)
            
            let behaviorAndWidth = getBehaviorAndWidthDimension(section: section, width: width, layoutEnvironment: layoutEnvironment)
            behavior = behaviorAndWidth.behavior
            
            
            groupHeight = height.dimension()
            groupWidth = behaviorAndWidth.width
        }

        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: subitems)

        group.interItemSpacing = .fixed(section.interItemSpacing)
        let collectionSection = NSCollectionLayoutSection(group: group)
        collectionSection.orthogonalScrollingBehavior = behavior
        collectionSection.interGroupSpacing = section.interItemSpacing

        switch section.background {
        case .grouped:
            let margin = DSAppearance.shared.main.groupMargins
            let insets = section.insets.add(margin).directionalEdgeInsets
            collectionSection.contentInsets = insets
        case .`default`, .primaryBackground, .secondaryBackground:
            switch section.galleryType {
            case .default:
                collectionSection.contentInsets = section.insets.directionalEdgeInsets
            case .fullWidth:
                collectionSection.contentInsets = section.insets.zeroLeftRightDirectionalEdgeInsets
            }
        }
        
        return applyDefaultSupplementaryViewLayout(section: section,
                                                   collectionLayoutSection: collectionSection,
                                                   group: group, layoutEnvironment)
    }

    fileprivate func getBehaviorAndWidthDimension(section: DSGallerySection,
                                                  width: DSViewModelWidth,
                                                  layoutEnvironment: NSCollectionLayoutEnvironment) -> (width: NSCollectionLayoutDimension,
                                                                                                        behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) {
        
        var widthDimension: NSCollectionLayoutDimension = .absolute(layoutEnvironment.container.contentSize.width)
        var behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
        
        if width.isFractional {
            
            if width.dimension().dimension == 1.0 {
                
                switch section.galleryType {
                case .default:
                    let margins: CGFloat = section.background.isGrouped ? DSAppearance.shared.main.groupMargins : 0
                    let insets = (margins + DSAppearance.shared.main.margins) * 2
                    widthDimension = .absolute(layoutEnvironment.container.contentSize.width - insets)
                case .fullWidth:
                    widthDimension = .absolute(view.frame.width)
                }
                
                behavior = .groupPaging
                
            } else {
                widthDimension = .estimated(layoutEnvironment.container.contentSize.width)
                behavior = .continuous
            }
            
        } else if width.isAbsolute {
            widthDimension = width.dimension()
            behavior = .continuous
        } else if width.isEstimated {
            widthDimension = width.dimension()
            behavior = .continuous
        }
        
        return (width: widthDimension, behavior: behavior)
    }
}
