import Foundation

extension DSSection {

    var diffableHash: Int {
        
        var hasher = Hasher()
        
        if let headerHash = self.headerModelHash {
            hasher.combine(headerHash)
        }
        
        if let footerHash = self.footerModelHash {
            hasher.combine(footerHash)
        }
        
        hasher.combine(self.type.hashValue)
        
        return hasher.finalize()
    }

    var footerModelHash: Int? {
        
        if let model = footer {
            var hasher = Hasher()
            hasher.combine(model.hash())
            return hasher.finalize()
        }
        
        return nil
    }
    
    var headerModelHash: Int? {
        
        if let model = header {
            var hasher = Hasher()
            hasher.combine(model.hash())
            return hasher.finalize()
        }
        
        return nil
    }
}
