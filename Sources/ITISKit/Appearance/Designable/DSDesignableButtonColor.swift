import UIKit


public struct DSDesignableButtonColor: Equatable, Hashable {

    public init(background: UIColor, title: UIColor) {
        self.background = background
        self.title = title
    }

    public var background: UIColor
    public var title: UIColor
}
