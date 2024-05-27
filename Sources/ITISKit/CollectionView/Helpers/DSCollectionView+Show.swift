import UIKit

extension DSCollectionView {

    func updateContent(animated: Bool, scrollToBottom: Bool) {
        
        var animated = animated

        if ProcessInfo.processInfo.arguments.contains("TEST_MODE") {
            animated = false
        }

        self.adaptedContent = prepareContentToBeDisplayed(originalContent)
        self.snapshot = NSDiffableDataSourceSnapshot<DSDiffableSection, DSViewModelDataSource>()

        var alreadyUsedHashes = [Int]()
        for (index, section) in adaptedContent.enumerated() {
            let displayModels = section.viewModels.map { (model) -> DSViewModelDataSource in
                DSViewModelDataSource(model: model)
            }
            if let identifier = section.identifier?.hash, !alreadyUsedHashes.contains(identifier) {
                alreadyUsedHashes.append(identifier)
                snapshot?.appendSections([.section(id: identifier)])  
            } else if !alreadyUsedHashes.contains(section.diffableHash) {
                let identifier = section.diffableHash
                alreadyUsedHashes.append(identifier)
                snapshot?.appendSections([.section(id: identifier)])
            } else {
                let identifier = section.hashValue + index
                
                alreadyUsedHashes.append(identifier)
                snapshot?.appendSections([.section(id: identifier)])
            }
            snapshot?.appendItems(displayModels)
        }
        self.applySnapshot(animated: animated, scrollToBottom: scrollToBottom)
    }
    
    func applySnapshot(animated: Bool, scrollToBottom: Bool) {
        
        guard let snapshot = self.snapshot else {
            return
        }

        dataSource.apply(snapshot, animatingDifferences: animated, completion: {
            if scrollToBottom {
                self.scrollToBottom(animated: true)
            }
            
            self.contentSizeDidUpdate?(self.view.contentSize)
        })
    }
    
    
    
    
    
    
    public func show(content newContent: [DSSection], animated: Bool = true, scrollToBottom: Bool = false) {
        
        self.originalContent.removeAll()
        self.originalContent.append(contentsOf: newContent)
        self.updateContent(animated: animated, scrollToBottom: scrollToBottom)
    }
    
    
    
    
    func prepareContentToBeDisplayed(_ content: [DSSection]) -> [DSSection] {
        
        var adaptedContent = [DSSection]()
        adaptedContent.append(contentsOf: content)
        
        
        if additionalTopContentSpace != 0 {
            var space = DSSpaceVM(type: .custom(additionalTopContentSpace))
            space.identifier = "AdditionalTopSpace"
            let section = space.list()
            section.identifier = "AdditionalTopSpaceSection"
            section.zeroTopBottomInset()
            adaptedContent.insert(section, at: 0)
        }
        
        
        let safeArea = UIApplication.shared.topMostViewController()?.view.safeAreaInsets.bottom ?? 0
                
        let containSafeArea = safeArea > 0
        let shouldAddSpace = (position == .bottom && containSafeArea)        
        
        
        if adaptedContent.totalViewModelsCount > 0 && !shouldAddSpace {
            
            if let topInsetsOfFirstSection = content.first?.insets.top {
                
                let space = DSSpaceVM(type: .custom(topInsetsOfFirstSection))
                let section = space.list(identifier: "AdditionalBottomContentSpaceMargin")
                section.identifier = "AdditionalBottomContentSpaceMargin"
                section.zeroTopBottomInset()
                adaptedContent.append(section)
                
            } else {
                
                let space = DSSpaceVM()
                let section = space.list(identifier: "AdditionalBottomContentSpaceMargin")
                section.identifier = "AdditionalBottomContentSpaceMargin"
                section.zeroTopBottomInset()
                adaptedContent.append(section)
            }
            
        } else if adaptedContent.totalViewModelsCount > 0 && shouldAddSpace {
         
            let space = DSSpaceVM()
            let section = space.list(identifier: "AdditionalBottomContentSpaceMargin")
            section.identifier = "AdditionalBottomContentSpaceMargin"
            section.zeroTopBottomInset()
            adaptedContent.append(section)
        }
        
        adaptedContent = adaptedContent.filter { (section) -> Bool in
            return !section.viewModels.isEmpty
        }
        
        
        if additionalBottomContentSpace != 0 {
            var space = DSSpaceVM(type: .custom(additionalBottomContentSpace))
            space.identifier = "AdditionalBottomSpace"
            let section = space.list()
            section.identifier = "AdditionalBottomSpaceSection"
            section.zeroTopBottomInset()
            adaptedContent.append(section)
        }
        
        
        adaptedContent.prepareViewModelsDisplayStyle()
        adaptedContent.prepareViewModelsIdentifiers()
        
        return adaptedContent
    }
}
