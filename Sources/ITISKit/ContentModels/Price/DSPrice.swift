import Foundation
import UIKit

public struct DSPrice: Equatable, Hashable {
    
    public let amount: String
    public let regularAmount: String?
    public let currency: String
    public var discountBadge: String?
    
    public init(amount: String, regularAmount: String? = nil, currency: String, discountBadge: String? = nil) {
        self.amount = amount
        self.currency = currency
        self.discountBadge = discountBadge
        self.regularAmount = regularAmount
    }
}

public extension DSPrice {
    
    enum DisplaySize {
        case small
        case medium
        case large
        case extraLarge
    }
    
    enum DisplayColor: Equatable, Hashable {
        case `default`
        case custom(DSDesignablePriceColor)
    }
    
    func asAttributedString(size: DisplaySize, color: DisplayColor, alignment: NSTextAlignment, spacing: CGFloat) -> NSAttributedString {
        
        var scaleFactor: CGFloat = 1.0
        switch size {
        case .small:
            scaleFactor = 1.0
        case .medium:
            scaleFactor = 1.3
        case .large:
            scaleFactor = 1.6
        case .extraLarge:
            scaleFactor = 2.0
        }
        
        return asAttributedString(color: color, scaleFactor: scaleFactor, spacing: spacing, alignment: alignment)
    }
    
    func asAttributedString(color: DisplayColor, scaleFactor: CGFloat, spacing: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
        return getAmountMediumAttributedString(color: color, scaleFactor: scaleFactor, spacing: spacing, alignment: alignment)
    }

    func getAmountMediumAttributedString(color: DisplayColor, scaleFactor: CGFloat = 1.0, spacing: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
        
        let appearance = DSAppearance.shared.main
        let fonts = DSDesignableFonts()
        
        var priceColors = appearance.price
        
        switch color {
        case .default:
            priceColors = appearance.price
        case .custom(let colors):
            priceColors = colors
        }
        
        let finalString = NSMutableAttributedString()
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignment
        
        let currencyFont = UIFont(name: "Futura Medium", size: 11 * scaleFactor)
        let amountFont = UIFont(name: "Futura Medium", size: 12 * scaleFactor)
        let regularFont = UIFont(name: "Futura Medium", size: 12 * scaleFactor)

        attributes = [
            .foregroundColor: priceColors.currency,
            .font: currencyFont ?? UIFont.systemFont(ofSize: 11 * scaleFactor),
            .paragraphStyle: paragraphStyle
        ]
        let currencyString = NSAttributedString(string: currency.currencySymbol + "", attributes: attributes)
        finalString.append(currencyString)

        attributes = [
            .foregroundColor: priceColors.amount,
            .font: amountFont ?? UIFont.systemFont(ofSize: 12 * scaleFactor),
        ]
        let amountString = NSAttributedString(string: amount + " ", attributes: attributes)
        finalString.append(amountString)

        if let regularAmount = regularAmount {
            attributes = [
                .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
                .foregroundColor: priceColors.regularAmount,
                .font: regularFont ?? UIFont.systemFont(ofSize: 12 * scaleFactor)
            ]
            let regularAmountString = NSAttributedString(string: regularAmount + " ", attributes: attributes)
            finalString.append(regularAmountString)
        }
        
        if let discountBadge = discountBadge {
            
            let futura = UIFont(name: "Futura Medium", size: 9 * scaleFactor)
            let font = futura != nil ? futura! : fonts.headline.withSize(9 * scaleFactor)
            
            let badgeString = NSAttributedString.badge(text: discountBadge,
                                                       font: font,
                                                       textColor: priceColors.badgeText,
                                                       backgroundColor: priceColors.badgeBackground,
                                                       cornerRadius: priceColors.badgeCornerRadius)
            
            finalString.append(NSAttributedString(string: " "))
            finalString.append(badgeString)
        }
        
        return finalString
    }
}

