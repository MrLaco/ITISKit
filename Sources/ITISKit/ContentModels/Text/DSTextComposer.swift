import UIKit


public class DSTextComposer: Equatable, Hashable {

    var alignment: NSTextAlignment

    public init(alignment: NSTextAlignment = .natural) {
        self.alignment = alignment
    }

    var paragraphs: [DSTextParagraph] = []
    
    public static func == (lhs: DSTextComposer, rhs: DSTextComposer) -> Bool {
        return lhs.paragraphs == rhs.paragraphs
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(paragraphs)
    }
}

public extension DSTextComposer {

    func estimatedHeight(section: DSSection, _ layoutEnvironment: NSCollectionLayoutEnvironment?) -> DSViewModelHeight {
        
        let appearance = DSAppearance.shared.main.primaryView
        let text = self.attributedString(designableTextColor: appearance.text)
        var font = UIFont.systemFont(ofSize: 10)
        
        if let paragraph = paragraphs.first {
            switch paragraph.type {
            case .text(icon: _, text: _, font: let paragraphFont, color: _):
                font = paragraphFont
            default:
                break
            }
        }
        
        let width = section.sectionWidth(layoutEnvironment)
        
        
        let height = text.height(forFixedWidth: width, font: font)
        return .estimated(height)
    }

    func calculatedWidth(section: DSSection, _ layoutEnvironment: NSCollectionLayoutEnvironment?) -> CGFloat {
        
        let appearance = DSAppearance.shared.main.primaryView
        let text = self.attributedString(designableTextColor: appearance.text)
        var font = UIFont.systemFont(ofSize: 10)

        if let paragraph = paragraphs.first {
            switch paragraph.type {
            case .text(icon: _, text: _, font: let paragraphFont, color: _):
                font = paragraphFont
            default:
                break
            }
        }
        
        let height = section.sectionHeight(layoutEnvironment)
        let width = text.width(forFixedHeight: height, font: font)
        
        return width + section.insets.width
    }
}
