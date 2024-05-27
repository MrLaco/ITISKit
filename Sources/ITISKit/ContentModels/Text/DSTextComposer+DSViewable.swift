import UIKit

extension DSTextComposer: DSViewable {

    func view(_ designableViewColors: DSDesignableViewColors) -> UIView {
        let label = UILabel()
        label.set(text: self, designableTextColor: designableViewColors.text)
        return label
    }
}
