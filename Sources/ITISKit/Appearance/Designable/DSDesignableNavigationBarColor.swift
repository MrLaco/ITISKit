import UIKit


public struct DSDesignableNavigationBarColor {

    public init(buttons: UIColor, text: UIColor, bar: UIColor, translucent: Bool = false) {
        self.buttons = buttons
        self.text = text
        self.bar = bar
        self.translucent = translucent
    }

    public var buttons: UIColor
    public var text: UIColor
    public var bar: UIColor
    public var translucent: Bool
}
