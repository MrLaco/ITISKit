import UIKit

public final class DSGridSection: DSSection {

    public init(viewModels: [DSViewModel], columns: Int = 2) {
        super.init()
        self.viewModels = viewModels
        
        let appearance = DSAppearance.shared.main
        
        insets = UIEdgeInsets(top: appearance.margins,
                              left: appearance.margins,
                              bottom: 0,
                              right: appearance.margins)
        
        type = .grid(columns: columns)
        interItemSpacing = appearance.interItemSpacing
    }
}


