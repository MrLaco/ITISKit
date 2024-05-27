import UIKit

public extension DSActionVM {

    mutating func topImage(image: UIImage?,
                           height: DSImageHeight = .unknown,
                           contentMode: DSImageContentMode = .scaleAspectFill) {
        
        self.topImage = DSImageContent.image(image: image)
        self.topImageContentMode = contentMode
        self.topImageHeight = height
    }
    
    mutating func topImage(url: URL?,
                           height: DSImageHeight = .unknown,
                           contentMode: DSImageContentMode = .scaleAspectFill) {
        
        self.topImage = DSImageContent.imageURL(url: url)
        self.topImageContentMode = contentMode
        self.topImageHeight = height
    }
}
