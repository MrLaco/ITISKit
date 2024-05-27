import UIKit

extension DSCollectionView {

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard sectionIndex < self.adaptedContent.count else {
                return nil
            }

            let section = self.adaptedContent[sectionIndex]
            
            switch section.type {
            case .list:
                guard let section = section as? DSListSection else { break }
                return self.listLayout(section: section, layoutEnvironment)
            case .gallery:
                guard let section = section as? DSGallerySection else { break }
                return self.galleryLayout(section: section, layoutEnvironment)
            case .grid(columns: let columns):
                guard let section = section as? DSGridSection else { break }
                return self.gridLayout(section: section, columns: columns, layoutEnvironment)
            }
            
            return nil
        }

        layout.register(DSSectionBackgroundDecorationView.self,
                        forDecorationViewOfKind: DSCollectionView.sectionBackgroundDecorationElementKind)
        layout.register(DSSectionBackgroundColorPrimaryDecorationView.self,
                        forDecorationViewOfKind: DSCollectionView.sectionBackgroundColorPrimaryDecorationElementKind)
        layout.register(DSSectionBackgroundColorSecondaryDecorationView.self,
                        forDecorationViewOfKind: DSCollectionView.sectionBackgroundColorSecondaryDecorationElementKind)
        
        return layout
    }
}
