import UIKit

public struct DSPageControlVM: DSViewModel, Equatable, Hashable {
    
    public var currentPage: Int
    public var type: DSPageControlVMType
    public var galleryType: DSSectionGalleryType = .default
    
    @NonEquatable public var updatePage: ((Int) -> Void)?
    
    public init(type: DSPageControlVMType, galleryType: DSSectionGalleryType = .default, currentPage: Int = 0) {
        self.type = type
        self.galleryType = galleryType
        self.currentPage = currentPage
    }

    public var height: DSViewModelHeight = .estimated(30)
    public var width: DSViewModelWidth = .fractional(1.0)
    public var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var identifier = "PageControl"
    public var accessibilityIdentifier = "PageControl"
    public var style: DSViewModelStyle = DSViewModelStyle()

    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var object: AnyObject?

    public var supplementaryItems: [DSSupplementaryView]?
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
}

public extension DSPageControlVM {

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        
        if let height = type.getHeight(layoutEnvironment), let absoluteHeight = height.absolute() {
            return .absolute(absoluteHeight+38)
        }
        
        return height
    }
    
    func viewRepresentation() -> DSReusableUIView {
        return DSPageControlUIView.instanceFromNib()
    }
    
    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }
}

public enum DSPageControlVMType: Equatable, Hashable {
    
    public static func == (lhs: DSPageControlVMType, rhs: DSPageControlVMType) -> Bool {
        
        switch lhs {
        case .pages(let lpages):
            
            switch rhs {
            case .pages(let rpages):
                return lpages == rpages
            case .viewModels(_):
                return false
            }
            
        case .viewModels(let lmodels):
            
            switch rhs {
            case .pages(_):
                return false
            case .viewModels(let rmodels):
                return lmodels.isEqual(to: rmodels)
            }
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .pages(let pages):
            hasher.combine(pages)
        case .viewModels(let models):
            for model in models {
                hasher.combine(model.hash())
            }
        }
    }
    
    case viewModels([DSViewModel])
    case pages([DSPageVM])
    
    func getHeight(_ layoutEnvironment: NSCollectionLayoutEnvironment?) -> DSViewModelHeight? {
        
        switch self {
        case .pages(let pages):
            
            guard let first = pages.first else {
                return nil
            }
            
            return first.height
            
        case .viewModels(let models):
            
            guard let first = models.first else {
                return nil
            }
            
            return first.height(layoutEnvironment, section: DSSection())
        }
    }
}
