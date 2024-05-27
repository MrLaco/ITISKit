import UIKit

extension DSPrice: DSViewable {
    
    func view(_ designableViewColors: DSDesignableViewColors) -> UIView {
        
        let label = UILabel()
        let composer = DSTextComposer()
        composer.add(price: self)
        label.set(text: composer, designableTextColor: designableViewColors.text)
        return label
    }
}
