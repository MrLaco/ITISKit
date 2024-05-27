import UIKit
import Combine


public class DSAppearance {
    internal var appearancePublisher = PassthroughSubject<DSDesignable, Never>()
    public static let shared = DSAppearance()
    public var main: DSDesignable = SystemAppearance() {
        didSet {
            appearancePublisher.send(main)
        }
    }
    public var userInterfaceStyle: UIUserInterfaceStyle = .unspecified {
        didSet {
            appearancePublisher.send(main)
        }
    }
}

public extension DSAppearance {
    static func allAppearances() -> [DSDesignable] {
        
        return [SystemAppearance(),
                DSKitAppearance(),
                DSNewsAppearance(),
                MintAppearance(),
        ]
    }

    static func appearanceWith(title: String) -> DSDesignable? {
        
        let appearances = DSAppearance.allAppearances().filter { (app: DSDesignable) -> Bool in
            app.title == title
        }
        
        return appearances.first
    }
}
