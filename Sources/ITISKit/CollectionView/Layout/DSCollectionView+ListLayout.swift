import UIKit

extension DSCollectionView {

    func listLayout(section: DSListSection, _ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        
        var items = [NSCollectionLayoutItem]()
        var estimatedSectionHeight: CGFloat = 1

        for model in section.viewModels {
            let width = model.width(layoutEnvironment, section: section)
            let height = model.height(layoutEnvironment, section: section)
            let itemSize = NSCollectionLayoutSize(widthDimension: width.dimension(),
                                                  heightDimension: height.dimension())
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            estimatedSectionHeight += height.dimension().dimension
            items.append(item)
        }
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(estimatedSectionHeight > 0 ? estimatedSectionHeight : 20))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: items)
        
        
        group.interItemSpacing = .fixed(section.interItemSpacing)
        let collectionSection = NSCollectionLayoutSection(group: group)
        collectionSection.orthogonalScrollingBehavior = .none
        collectionSection.interGroupSpacing = section.interItemSpacing
        
        switch section.background {
        case .grouped:
            let margin = DSAppearance.shared.main.groupMargins
            let insets = section.insets.add(margin).directionalEdgeInsets
            collectionSection.contentInsets = insets
        case .`default`, .primaryBackground, .secondaryBackground:
            collectionSection.contentInsets = section.insets.directionalEdgeInsets
        }
        
        return applyDefaultSupplementaryViewLayout(section: section, collectionLayoutSection: collectionSection, group: group, layoutEnvironment)
    }
}
