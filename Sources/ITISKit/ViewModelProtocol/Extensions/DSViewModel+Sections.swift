import Foundation

public extension DSViewModel {

    func list(separator: Bool = false, grouped: Bool = false, identifier: String? = nil) -> DSSection {
        let models: [DSViewModel] = [self]
        let section = models.list(separator: separator, grouped: grouped)
        section.identifier = identifier
        return section
    }

    func gallery(type: DSSectionGalleryType = .default, grouped: Bool = false, identifier: String? = nil) -> DSSection {
        
        let models: [DSViewModel] = [self]
        let section = models.gallery(type: type, grouped: grouped, identifier: identifier)
        section.identifier = identifier
        return section
    }
}

public extension Array where Element == DSViewModel {

    func list(separator: Bool, identifier: String? = nil) -> DSSection {
        
        let section = DSListSection(viewModels: self, separator: separator)
        section.identifier = identifier
        section.background = .`default`
        return section
    }

    func list(grouped: Bool, identifier: String? = nil) -> DSSection {
        
        let section = DSListSection(viewModels: self, separator: false)
        section.identifier = identifier
        section.background = (grouped ? .grouped : .`default`)
        return section
    }

    func list(separator: Bool = false, grouped: Bool = false, identifier: String? = nil) -> DSSection {
        
        let section = DSListSection(viewModels: self, separator: separator)
        section.identifier = identifier
        section.background = (grouped ? .grouped : .`default`)
        return section
    }

    func grid(columns: Int = 2, grouped: Bool = false, identifier: String? = nil) -> DSSection {
        
        let section = DSGridSection(viewModels: self, columns: columns)
        section.background = (grouped ? .grouped : .`default`)
        section.identifier = identifier
        return section
    }

    func gallery(type: DSSectionGalleryType = .default, grouped: Bool = false, identifier: String? = nil) -> DSSection {
        
        let section = DSGallerySection(viewModels: self, type: type)
        section.identifier = identifier
        section.background = (grouped ? .grouped : .`default`)
        
        return section
    }
}
