public extension DSViewController {

    func showTop(content: [DSViewModel]) {
        topContentQueue.append(QueuedContent(content: [content.list()], animated: true, scrollToBottom: false))
        applyCurrentContentQueueIfPossible()
    }

    func showTop(content newContent: DSSection, animated: Bool = true) {
        topContentQueue.append(QueuedContent(content: [newContent], animated: animated, scrollToBottom: false))
        applyCurrentContentQueueIfPossible()
    }

    func showTop(content newContent: [DSSection], animated: Bool = true) {
        topContentQueue.append(QueuedContent(content: newContent, animated: animated, scrollToBottom: false))
        applyCurrentContentQueueIfPossible()
    }

    func hideTopContent() {
        topCollectionView.show(content: [[DSViewModel]().list()])
        if collectionView.additionalTopContentSpace != 0 {
            adaptTopContentToNewHeight(height: 0)
        }
    }
}
