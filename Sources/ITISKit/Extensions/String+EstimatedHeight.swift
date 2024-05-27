import UIKit

extension String {

    func estimatedHeight(textType: DSTextType, section: DSSection, _ layoutEnvironment: NSCollectionLayoutEnvironment?) -> DSViewModelHeight {
        
        let width = section.sectionWidth(layoutEnvironment)
        let height = self.height(forFixedWidth: width, font: textType.style.font.getFont())
        return .estimated(height)
    }
}
