import Foundation

extension Array where Element == DSSection {

    func prepareViewModelsIdentifiers() {
        updateIdentifierFromModelIndexAndTypeIfNeed()
        updateRandomIdentifierIfNeed()
    }
    
    fileprivate func getDuplicatesHashes() -> [String] {
        
        
        let hashValues = self.map { (section) -> [String] in
            section.viewModels.map { (model) -> String in
                return model.hash()
            }
        }.flatMap({ $0 })
        
        
        return Dictionary(grouping: hashValues, by: {$0}).filter { $1.count > 1 }.keys.map { (key) -> String in
            return key
        }
    }
    
    
    fileprivate func updateIdentifierFromModelIndexAndTypeIfNeed() {
        
        let duplicates = getDuplicatesHashes()
        
        
        if !duplicates.isEmpty {
            for (_, section) in self.enumerated() {
                for (modelIndex, model) in section.viewModels.enumerated() {
                    if duplicates.contains(model.hash()) {
                        var model = model
                        model.identifier = "Row" + modelIndex.string() + model.style.displayStyle.rawValue
                        section.viewModels[modelIndex] = model
                    }
                }
            }
        }
    }
    
    
    fileprivate func updateRandomIdentifierIfNeed() {
        
        let duplicates = getDuplicatesHashes()
        
        if !duplicates.isEmpty {
            for (_, section) in self.enumerated() {
                for (modelIndex, model) in section.viewModels.enumerated() {
                    if duplicates.contains(model.hash()) {
                        var model = model
                        model.identifier = Int.random(in: 1...9000000000).string()
                        section.viewModels[modelIndex] = model
                    }
                }
            }
        }
    }
}
