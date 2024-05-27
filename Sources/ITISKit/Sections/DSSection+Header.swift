import Foundation
import UIKit

public extension DSSection {

    @discardableResult func title1Header(_ text: String) -> Self {
        self.header = header(type: .title1, text: text)
        return self
    }

    @discardableResult func title2Header(_ text: String) -> Self {
        self.header = header(type: .title2, text: text)
        return self
    }

    @discardableResult func title3Header(_ text: String) -> Self {
        self.header = header(type: .title3, text: text)
        return self
    }

    @discardableResult func headlineHeader(_ text: String) -> Self {
        self.header = header(type: .headline, text: text)
        return self
    }

    @discardableResult func headlineHeader(_ text: String, size: CGFloat) -> Self {
        self.header = header(type: .headlineWithSize(size), text: text)
        return self
    }

    @discardableResult func subheadlineHeader(_ text: String) -> Self {
        self.header = header(type: .subheadline, text: text)
        return self
    }

    @discardableResult func caption2Header(_ text: String) -> Self {
        self.header = header(type: .caption2, text: text)
        return self
    }

    fileprivate func header(type: DSTextType, text: String) -> DSViewModel {
        
        var model = DSLabelVM(type, text: text)
        let font = type.style.font
        let width = UIScreen.main.bounds.width - (DSAppearance.shared.main.margins * 2)
        model.height = .absolute(text.height(forFixedWidth: width, font: font.getFont()))
        return model
    }
}
