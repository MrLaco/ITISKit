import UIKit


public struct DSDesignableTextFieldColor: Equatable, Hashable {

    public init(border: UIColor,
                background: UIColor,
                text: UIColor,
                placeHolder: UIColor) {
        self.border = border
        self.background = background
        self.text = text
        self.placeHolder = placeHolder
    }

    public var border: UIColor
    public var background: UIColor
    public var text: UIColor
    public var placeHolder: UIColor
}
