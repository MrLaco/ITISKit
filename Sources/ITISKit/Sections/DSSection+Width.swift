import Foundation
import UIKit

extension DSSection {

    func sectionWidth(_ layoutEnvironment: NSCollectionLayoutEnvironment?) -> CGFloat {

        var width: CGFloat = 0
        if let contentSizeWidth = layoutEnvironment?.container.contentSize.width {
            width = contentSizeWidth
        } else {
            width = UIScreen.main.bounds.width
        }
        
        
        if self.background.isGrouped {
            width -= DSAppearance.shared.main.groupMargins * 2
        }
        
        
        width -= self.insets.width
        
        return width
    }
    
    func sectionHeight(_ layoutEnvironment: NSCollectionLayoutEnvironment?) -> CGFloat {
        
        
        var height: CGFloat = 0
        if let contentSizeHeight = layoutEnvironment?.container.contentSize.height {
            height = contentSizeHeight
        } else {
            height = UIScreen.main.bounds.height
        }
        
        
        if self.background.isGrouped {
            height -= DSAppearance.shared.main.groupMargins * 2
        }
        
        
        height -= self.insets.width
        
        return height
    }
}
