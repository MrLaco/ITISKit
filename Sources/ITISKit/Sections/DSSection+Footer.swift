import Foundation
import UIKit

public extension DSSection {
    @discardableResult func headlineFooter(_ text: String) -> Self {
        self.footer = DSLabelVM(.headline, text: text)
        return self
    }

    @discardableResult func subheadlineFooter(_ text: String) -> Self {
        self.footer = DSLabelVM(.subheadline, text: text)
        return self
    }
}
