import Foundation
import UIKit

extension DSTextComposer {

    public func add(text: NSAttributedString, newLine: Bool = true) {
        
        let paragraph = DSTextParagraph(type: .attributed(text: text),
                                        newLine: newLine,
                                        spacing: 0,
                                        lineSpacing: 0,
                                        maximumLineHeight: 0)
        paragraphs.append(paragraph)
    }

    public func add(type: DSTextType,
                    text: String,
                    icon: UIImage? = nil,
                    spacing: CGFloat = 0,
                    lineSpacing: CGFloat = 0,
                    maximumLineHeight: CGFloat = 0,
                    newLine: Bool = true) {
        
        let style = type.style
        
        let paragraph = DSTextParagraph(type: .text(icon: icon, text: text, font: style.font.getFont(), color: style.color),
                                        newLine: newLine,
                                        spacing: spacing,
                                        lineSpacing: lineSpacing,
                                        maximumLineHeight: maximumLineHeight)
        paragraphs.append(paragraph)
    }

    public func add(badge: String,
                    type: DSTextType,
                    backgroundColor: UIColor,
                    cornerRadius: CGFloat,
                    spacing: CGFloat = 0,
                    lineSpacing: CGFloat = 0,
                    maximumLineHeight: CGFloat = 0,
                    newLine: Bool = true) {
        
        let paragraph = DSTextParagraph(type: .badge(text: badge, type: type, backgroundColor: backgroundColor, cornerRadius: cornerRadius),
                                        newLine: newLine,
                                        spacing: spacing,
                                        lineSpacing: lineSpacing,
                                        maximumLineHeight: maximumLineHeight)
        paragraphs.append(paragraph)
    }

    public func add(sfSymbol: String,
                    style: DSSFSymbolConfigStyle = .medium,
                    tint: DSTextColor = .headline,
                    spacing: CGFloat = 0,
                    lineSpacing: CGFloat = 0,
                    maximumLineHeight: CGFloat = 0,
                    newLine: Bool = true) {
        
        let paragraph = DSTextParagraph(type: .symbol(sfSymbol: sfSymbol, style: style, tint: tint),
                                        newLine: newLine,
                                        spacing: spacing,
                                        lineSpacing: lineSpacing,
                                        maximumLineHeight: maximumLineHeight)
        paragraphs.append(paragraph)
    }

    public func add(image: UIImage?,
                    size: CGSize,
                    spacing: CGFloat = 0,
                    lineSpacing: CGFloat = 0,
                    maximumLineHeight: CGFloat = 0,
                    newLine: Bool = true) {
        
        if let image = image {
            
            let paragraph = DSTextParagraph(type: .image(image: image, size: size),
                                            newLine: newLine,
                                            spacing: spacing,
                                            lineSpacing: lineSpacing,
                                            maximumLineHeight: maximumLineHeight)
            paragraphs.append(paragraph)
            
        }

    }

    public func add(sfSymbols: [String],
                    style: DSSFSymbolConfigStyle = .medium,
                    tint: DSTextColor = .headline,
                    spacing: CGFloat = 0,
                    lineSpacing: CGFloat = 0,
                    maximumLineHeight: CGFloat = 0,
                    newLine: Bool = true) {
        
        let paragraph = DSTextParagraph(type: .symbols(sfSymbols: sfSymbols, style: style, tint: tint),
                                        newLine: newLine,
                                        spacing: spacing,
                                        lineSpacing: lineSpacing,
                                        maximumLineHeight: maximumLineHeight)
        paragraphs.append(paragraph)
    }

    public func add(rating: Int,
                    maximumValue: Int,
                    positiveSymbol: String,
                    negativeSymbol: String,
                    style: DSSFSymbolConfigStyle = .medium,
                    tint: DSTextColor = .headline,
                    spacing: CGFloat = 0,
                    lineSpacing: CGFloat = 0,
                    maximumLineHeight: CGFloat = 0,
                    newLine: Bool = true) {
        
        var sfSymbols = [String]()
        
        for i in 1...maximumValue {
            if i <= rating {
                sfSymbols.append(positiveSymbol)
            } else {
                sfSymbols.append(negativeSymbol)
            }
        }
        
        let paragraph = DSTextParagraph(type: .symbols(sfSymbols: sfSymbols, style: style, tint: tint),
                                        newLine: newLine,
                                        spacing: spacing,
                                        lineSpacing: lineSpacing,
                                        maximumLineHeight: maximumLineHeight)
        paragraphs.append(paragraph)
    }

    public func add(price: DSPrice,
                    size: DSPrice.DisplaySize = .medium,
                    color: DSPrice.DisplayColor = .default,
                    spacing: CGFloat = 0,
                    lineSpacing: CGFloat = 0,
                    newLine: Bool = true) {
        
        let paragraph = DSTextParagraph(type: .price(price: price, size: size, color: color),
                                        newLine: newLine,
                                        spacing: spacing,
                                        lineSpacing: lineSpacing,
                                        maximumLineHeight: 0)
        paragraphs.append(paragraph)
    }
}
