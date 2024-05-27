import UIKit


public struct DSDesignableViewColors: Equatable, Hashable {

    public init(button: DSDesignableButtonColor,
                text: DSDesignableTextColor,
                textField: DSDesignableTextFieldColor,
                background: UIColor,
                separator: UIColor,
                cornerRadius: CGFloat) {
        
        self.button = button
        self.text = text
        self.background = background
        self.separator = separator
        self.cornerRadius = cornerRadius
        self.textField = textField
    }

    public var button: DSDesignableButtonColor
    public var text: DSDesignableTextColor
    public var textField: DSDesignableTextFieldColor
    public var background: UIColor
    public var separator: UIColor
    public var cornerRadius: CGFloat
}
