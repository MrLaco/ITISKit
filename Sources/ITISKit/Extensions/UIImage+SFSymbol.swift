import UIKit

public extension UIImage {
    static func symbolImage(with symbolName: String, configuration: UIImage.Configuration? = nil) -> UIImage? {
        if let symbolImage = UIImage(systemName: symbolName, withConfiguration: configuration) {
            return symbolImage
        } else if let customSymbolImage = UIImage(named: symbolName, in: nil, with: configuration) {
            return customSymbolImage
        }
        
        return nil
    }
}
