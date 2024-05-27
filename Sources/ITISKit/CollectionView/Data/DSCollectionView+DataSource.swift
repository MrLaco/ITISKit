import UIKit

extension DSCollectionView {
    
    func configureDataSource() {
                
        dataSource = UICollectionViewDiffableDataSource<DSDiffableSection, DSViewModelDataSource>(collectionView: view, cellProvider: { [unowned self] (collection, indexPath, item) -> UICollectionViewCell? in
                        
            let section = self.adaptedContent[indexPath.section]
            let viewModel = section.viewModels[indexPath.row]
            
            var supplementaryItemsId = ""

            if let supplementaryItems = viewModel.supplementaryItems {
                for item in supplementaryItems {
                    supplementaryItemsId += item.view.reuseIdentifier()
                }
            }
            
            if viewModel.rightSideView != nil {
                supplementaryItemsId += "rightSideView"
            }
            
            if viewModel.leftSideView != nil {
                supplementaryItemsId += "leftSideView"
            }
            
            if viewModel.bottomSideView != nil {
                supplementaryItemsId += "bottomSideView"
            }
            
            if viewModel.topSideView != nil {
                supplementaryItemsId += "topSideView"
            }
            
            let viewReuseIdentifier = viewModel.reuseIdentifier() +
                DSAppearance.shared.main.title +
                DSAppearance.shared.userInterfaceStyle.rawValue.string() +
                viewModel.style.colorStyle.rawValue +
                viewModel.style.borderStyle.rawValue +
                viewModel.style.shadowStyle.rawValue +
                viewModel.style.cornerStyle.rawValue +
                supplementaryItemsId
            
            self.registerCellClassIfNeed(for: viewReuseIdentifier, cellClass: DSReusableCollectionViewCell.self)
            
            if let cell = collection.dequeueReusableCell(withReuseIdentifier: viewReuseIdentifier, for: indexPath) as? DSReusableCollectionViewCell {
                cell.setUpWith(viewModel: viewModel, section: section, viewIndex: indexPath.row)
                return cell
            }
            
            return nil
        })
        
    }
}
