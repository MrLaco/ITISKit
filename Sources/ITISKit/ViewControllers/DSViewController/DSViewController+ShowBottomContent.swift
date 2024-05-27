import Foundation

public extension DSViewController {

    func showBottom(content: DSViewModel) {
        
        bottomContentQueue.append(QueuedContent(content: [[content].list()],
                                                    animated: false,
                                                    scrollToBottom: false))
        applyCurrentContentQueueIfPossible()
    }

    func showBottom(content: [DSViewModel]) {
        
        bottomContentQueue.append(QueuedContent(content: [content.list()],
                                                    animated: false,
                                                    scrollToBottom: false))
        applyCurrentContentQueueIfPossible()
    }

    func showBottom(content newContent: DSSection, animated: Bool = true) {
        
        bottomContentQueue.append(QueuedContent(content: [newContent],
                                                    animated: animated,
                                                    scrollToBottom: false))
        applyCurrentContentQueueIfPossible()
    }

    func showBottom(content newContent: [DSSection], animated: Bool = true) {
        
        bottomContentQueue.append(QueuedContent(content: newContent,
                                                    animated: animated,
                                                    scrollToBottom: false))
        applyCurrentContentQueueIfPossible()
    }

    func hideBottomContent() {
        
        bottomCollectionView.show(content: [[DSViewModel]().list()])
        if collectionView.additionalBottomContentSpace != 0 {
            adaptBottomContentToNewHeight(height: 0)
        }
    }
}
