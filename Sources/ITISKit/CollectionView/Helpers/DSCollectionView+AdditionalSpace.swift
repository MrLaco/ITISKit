import UIKit

extension DSCollectionView {

    func setBottomAdditionalSpace(space: CGFloat) {
        
        additionalBottomContentSpace = space
        updateContent(animated: true, scrollToBottom: false)
        updateScrollIndicatorInsets()
    }

    func removeBottomAdditionalSpace() {
        additionalBottomContentSpace = 0
        show(content: self.originalContent, animated: false)
        updateScrollIndicatorInsets()
    }

    func setTopAdditionalSpace(space: CGFloat) {
        
        additionalTopContentSpace = space
        updateContent(animated: true, scrollToBottom: false)
        updateScrollIndicatorInsets()
    }
    
    func removeTopAdditionalSpace() {
        
        additionalTopContentSpace = 0
        show(content: self.originalContent, animated: false)
        updateScrollIndicatorInsets()
    }
    
    func updateScrollIndicatorInsets() {
        view.scrollIndicatorInsets = UIEdgeInsets(top: additionalTopContentSpace, left: 0, bottom: additionalBottomContentSpace, right: 0)
    }
}
