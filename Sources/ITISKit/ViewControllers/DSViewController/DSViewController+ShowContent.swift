import Foundation

public extension DSViewController {

    func show(content newContent: DSViewModel, animated: Bool = true, scrollToBottom: Bool = false) {
        
        centerContentQueue.append(QueuedContent(content: [newContent.list()],
                                                animated: animated,
                                                scrollToBottom: scrollToBottom))
        applyCurrentContentQueueIfPossible()
    }

    func show(content newContent: DSViewModel..., animated: Bool = true, scrollToBottom: Bool = false) {
        
        centerContentQueue.append(QueuedContent(content: [newContent.list()],
                                                animated: animated,
                                                scrollToBottom: scrollToBottom))
        applyCurrentContentQueueIfPossible()
    }

    func show(content newContent: [DSViewModel], animated: Bool = true, scrollToBottom: Bool = false) {
        
        centerContentQueue.append(QueuedContent(content: [newContent.list()],
                                                animated: animated,
                                                scrollToBottom: scrollToBottom))
        applyCurrentContentQueueIfPossible()
    }

    func show(content newContent: DSSection, animated: Bool = true, scrollToBottom: Bool = false) {
        
        centerContentQueue.append(QueuedContent(content: [newContent],
                                                animated: animated,
                                                scrollToBottom: scrollToBottom))
        applyCurrentContentQueueIfPossible()
    }

    func show(content newContent: DSSection..., animated: Bool = true, scrollToBottom: Bool = false) {
        
        centerContentQueue.append(QueuedContent(content: newContent,
                                                animated: animated,
                                                scrollToBottom: scrollToBottom))
        applyCurrentContentQueueIfPossible()
    }

    func show(content newContent: [DSSection], animated: Bool = true, scrollToBottom: Bool = false) {
        
        centerContentQueue.append(QueuedContent(content: newContent,
                                                animated: animated,
                                                scrollToBottom: scrollToBottom))
        applyCurrentContentQueueIfPossible()
    }

    func hideContent(animated: Bool = true) {
        
        centerContentQueue.append(QueuedContent(content: [DSSection](),
                                                animated: animated,
                                                scrollToBottom: false))
        applyCurrentContentQueueIfPossible()
    }
}
