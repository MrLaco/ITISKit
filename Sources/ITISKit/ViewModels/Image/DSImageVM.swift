import UIKit

public struct DSImageVM: DSViewModel, Equatable, Hashable {

    public var imageContent: DSImageContent
    public var imageDisplayStyle: DSImageDisplayStyle
    public var contentMode: DSImageContentMode = .scaleAspectFill
    public var tintColor: DSImageTintColor = .default

    public init(named: String,
                height: DSViewModelHeight = .fractional(1.0),
                displayStyle: DSImageDisplayStyle = .themeCornerRadius,
                contentMode: DSImageContentMode = .scaleAspectFill) {
        
        self.imageContent = .image(image: UIImage(named: named))
        self.height = height
        self.imageDisplayStyle = displayStyle
        self.contentMode = contentMode
    }

    public init(image: UIImage?,
                height: DSViewModelHeight = .fractional(1.0),
                displayStyle: DSImageDisplayStyle = .themeCornerRadius,
                contentMode: DSImageContentMode = .scaleAspectFill) {
        
        self.imageContent = .image(image: image)
        self.height = height
        self.imageDisplayStyle = displayStyle
        self.contentMode = contentMode
    }

    public init(imageValue: DSImageContent,
                height: DSViewModelHeight = .fractional(1.0),
                displayStyle: DSImageDisplayStyle = .themeCornerRadius ,
                contentMode: DSImageContentMode = .scaleAspectFill) {
        
        self.imageContent = imageValue
        self.height = height
        self.imageDisplayStyle = displayStyle
        self.contentMode = contentMode
    }

    public init(imageUrl: URL?,
                height: DSViewModelHeight = .fractional(1.0),
                displayStyle: DSImageDisplayStyle = .themeCornerRadius,
                contentMode: DSImageContentMode = .scaleAspectFill) {
        
        self.imageContent = DSImageContent.imageURL(url: imageUrl)
        self.height = height
        self.imageDisplayStyle = displayStyle
        self.contentMode = contentMode
    }

    public var height: DSViewModelHeight = .absolute(150)
    public var width: DSViewModelWidth = .fractional(1.0)
    public var type: ImageViewModelType = .default
    public var identifier = "Image"
    public var accessibilityIdentifier = "Image"
    public var style: DSViewModelStyle = DSViewModelStyle()

    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var object: AnyObject?

    public var supplementaryItems: [DSSupplementaryView]?
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
}

public enum ImageViewModelType {
    case `default`
}

public extension DSImageVM {
    
    func reuseIdentifier() -> String {
        
        var id = imageContent.rawValue
        id += imageDisplayStyle.rawValue
        id += contentMode.rawValue
        id += tintColor.rawValue
        id += style.displayStyle.rawValue
        id += width.rawValue
        id += height.rawValue
        
        return "DSImageVM" + id
    }

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        
        if height.isEstimated {
            
            guard let image = imageContent.image,
                  let containerWidth = layoutEnvironment?.container.contentSize.width,
                  let containerHeight = layoutEnvironment?.container.contentSize.height else {
                        return height
                    }
            
                    guard image.size.width > 0 && image.size.height > 0 else {
                        return height
                    }

                    let scale: CGFloat
                    if image.size.width > image.size.height {
                        scale = containerWidth / image.size.width
                    } else {
                        scale = containerHeight / image.size.height
                    }

                    let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
            
                return .absolute(size.height)
        }
        
        return height
    }

    func width(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelWidth {
        return width
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSImageUIView.instanceFromNib()
    }

    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }

    func hash() -> String {
        return hashValue.string()
    }
}
