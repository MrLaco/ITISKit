import Foundation

extension DSCollectionView {

    func reload(content newContent: [DSSection], animated: Bool = false, scrollToBottom: Bool = false) {
        show(content: newContent, animated: animated, scrollToBottom: scrollToBottom)
    }
    
    func reload(scrollToBottom: Bool = false, animated: Bool = false) {
        self.reload(content: self.originalContent, animated: animated, scrollToBottom: scrollToBottom)
    }
}
