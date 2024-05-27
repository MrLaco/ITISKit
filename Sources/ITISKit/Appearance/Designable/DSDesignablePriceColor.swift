import UIKit


public struct DSDesignablePriceColor: Equatable, Hashable {

    public init(currency: UIColor, amount: UIColor, regularAmount: UIColor, badgeBackground: UIColor = .red, badgeText: UIColor = .white, badgeCornerRadius: CGFloat = 4.0) {
        self.currency = currency
        self.amount = amount
        self.badgeText = badgeText
        self.badgeBackground = badgeBackground
        self.badgeCornerRadius = badgeCornerRadius
        self.regularAmount = regularAmount
    }

    var currency: UIColor
    var amount: UIColor
    var regularAmount: UIColor
    var badgeBackground: UIColor
    var badgeText: UIColor
    var badgeCornerRadius: CGFloat
}
