import UIKit

extension DSImage: DSViewable {
    
    public func view(_ designableViewColors: DSDesignableViewColors) -> UIView {
        let imageView = UIImageView()
        imageView.setImage(self, designableViewColors: designableViewColors)
        return imageView
    }
}
