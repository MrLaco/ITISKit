import UIKit

extension DSCollectionView {
    
    func configureSupplementaryViewDataSource()  {
        
        dataSource.supplementaryViewProvider = { view, kind, index in
            guard index.section < self.adaptedContent.count else {
                return nil
            }
            
            let section = self.adaptedContent[index.section]
            
            
            if kind == UICollectionView.elementKindSectionHeader {
                if let header = section.header {
                    return supplementaryView(viewModel: header,
                                             section: section,
                                             kind: UICollectionView.elementKindSectionHeader,
                                             index: index)
                }
            }

            if kind == UICollectionView.elementKindSectionFooter {
                if let footer = section.footer {
                    return supplementaryView(viewModel: footer,
                                             section: section,
                                             kind: UICollectionView.elementKindSectionFooter,
                                             index: index)
                }
            }
            
            return  nil
        }

        func supplementaryView(viewModel: DSViewModel,
                               section: DSSection,
                               kind: String,
                               index: IndexPath) -> DSReusableCollectionSupplementaryView? {
            
            let identifier = "Supplementary" + kind + viewModel.reuseIdentifier()
            self.registerClassForReusableViewIfNeed(kind: kind,
                                                    reuseIdentifier: identifier,
                                                    viewClass: DSReusableCollectionSupplementaryView.self)
            
            if let view = view.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: index) as? DSReusableCollectionSupplementaryView {
                view.setUpWith(viewModel: viewModel, section: section, kind: kind)
                return view
            }
            
            return nil
        }
    }
}
