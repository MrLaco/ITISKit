import Foundation
import UIKit

public extension DSQuantityPickerVM {

    func leftImage(image: UIImage?,
                            style: DSImageDisplayStyle = .themeCornerRadius,
                            size: DSImageSize = .size(CGSize(width: 50, height: 50)),
                            contentMode: DSImageContentMode = .scaleAspectFill) {
        
        let image = DSImage(content: .image(image: image),
                            displayStyle: style,
                            size: size,
                            tintColor: .text(.headline),
                            contentMode: contentMode)
        
        self.leftView = DSView(.image(image))
    }

    func leftImage(url: URL?,
                            style: DSImageDisplayStyle = .themeCornerRadius,
                            size: DSImageSize = .size(CGSize(width: 50, height: 50)),
                            contentMode: DSImageContentMode = .scaleAspectFill) {
        
        let image = DSImage(content: .imageURL(url: url),
                            displayStyle: style,
                            size: size,
                            tintColor: .text(.headline),
                            contentMode: contentMode)
        
        self.leftView = DSView(.image(image))
    }

    func leftRoundImage(url: URL?,
                                 size: CGSize = CGSize(width: 50, height: 50)) {
        
        let image = DSImage(content: .imageURL(url: url),
                            displayStyle: .circle, size: .size(size),
                            tintColor: .text(.headline),
                            contentMode: .scaleAspectFill)
        
        self.leftView = DSView(.image(image))
    }

    func leftRoundImage(image: UIImage?,
                                 size: CGSize = CGSize(width: 50, height: 50)) {
        
        let image = DSImage(content: .image(image: image),
                            displayStyle: .circle, size: .size(size),
                            tintColor: .text(.headline),
                            contentMode: .scaleAspectFill)
        
        self.leftView = DSView(.image(image))
    }

    func leftIcon(sfSymbolName: String,
                           size: CGSize = CGSize(width: 25, height: 25),
                           displayStyle: DSImageDisplayStyle = .default,
                           tintColor: DSImageTintColor = .text(.headline)) {
        
        let image = DSImage(content: .sfSymbol(name: sfSymbolName, style: .medium),
                            displayStyle: .default, size: .size(size),
                            tintColor: tintColor)
        
        self.leftView = DSView(.image(image))
    }
}
