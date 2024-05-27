import UIKit


public final class DSGallerySection: DSSection {
     
    public var galleryType: DSSectionGalleryType

    public init(viewModels: [DSViewModel], type: DSSectionGalleryType = .default) {
        
        self.galleryType = type
        super.init()        
        let appearance = DSAppearance.shared.main
        self.viewModels = viewModels
        self.type = .gallery(type: type)
        
        self.insets = UIEdgeInsets(top: appearance.margins,
                                   left: appearance.margins,
                                   bottom: 0,
                                   right: appearance.margins)
        
        self.interItemSpacing = appearance.interItemSpacing
    }
}
