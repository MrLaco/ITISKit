




























import UIKit





































public final class DSScaledFont {
    private struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String
    }

    private typealias DSStyleDictionary = [UIFont.TextStyle.RawValue: FontDescription]
    private var styleDictionary: DSStyleDictionary?

    
    
    
    
    

    public init(fontName: String) {
                
        if let url = Bundle(for: DSScaledFont.self).url(forResource: fontName, withExtension: "plist"),
            let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            styleDictionary = try? decoder.decode(DSStyleDictionary.self, from: data)
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    

    public func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
                
        guard let fontDescription = styleDictionary?[textStyle.rawValue],
            let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
            return UIFont.preferredFont(forTextStyle: textStyle)
        }

        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
    }
}
