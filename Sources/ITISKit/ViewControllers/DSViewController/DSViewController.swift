import UIKit
import Combine

open class DSViewController: DSCollectionViewController {
    
    struct QueuedContent {
        let content: [DSSection]
        let animated: Bool
        let scrollToBottom: Bool
    }
    
    var topContentQueue = [QueuedContent]()
    var centerContentQueue = [QueuedContent]()
    var bottomContentQueue = [QueuedContent]()
    var decorationIconView: UIView?
    
    
    public var decorationIcon = DSDecorationIcon() {
        didSet {
            updateDecorationIconView()
        }
    }
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    open override func appearanceDidUpdate() {
        super.appearanceDidUpdate()
        reloadAllContent()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        if traitCollection.userInterfaceStyle != lastTraitCollection?.userInterfaceStyle {
            lastTraitCollection = traitCollection
            reloadAllContent()
        }
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        
        lastTraitCollection = traitCollection
        reloadAllContent()
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        applyCurrentContentQueueIfPossible()
    }
    
    public func reloadAllContent() {
        
        if topCollectionView !== nil {
            topCollectionView.reload()
        }
        
        if topCollectionView !== nil {
            topCollectionView.reload()
        }
        
        if topCollectionView !== nil {
            topCollectionView.reload()
        }
    }
    
    func applyCurrentContentQueueIfPossible() {
        if ProcessInfo.processInfo.arguments.contains("TEST_MODE")  {
            showContentAllIfNeed()
        } else {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            self.perform(#selector(showContentAllIfNeed), with: nil, afterDelay: 0.05)
        }
    }

    @objc private func showContentAllIfNeed() {
        showTopContentIfNeed()
        showCenterContentIfNeed()
        showBottomContentIfNeed()
    }

    func showTopContentIfNeed() {
        
        guard let topCollectionView = topCollectionView, let display = topContentQueue.last else {
            return
        }
        
        topCollectionView.show(content: display.content,
                               animated: display.animated,
                               scrollToBottom: display.scrollToBottom)
        
        topContentQueue.removeAll()
    }

    func showCenterContentIfNeed() {
        
        guard let collectionView = collectionView, let display = centerContentQueue.last else {
            return
        }
        
        collectionView.show(content: display.content,
                            animated: display.animated,
                            scrollToBottom: display.scrollToBottom)
        
        centerContentQueue.removeAll()
    }

    func showBottomContentIfNeed() {
        
        guard let bottomCollectionView = bottomCollectionView, let display = bottomContentQueue.last else {
            return
        }
        
        bottomCollectionView.show(content: display.content,
                                  animated: display.animated,
                                  scrollToBottom: display.scrollToBottom)
        
        bottomContentQueue.removeAll()
    }

    public func setBounceContentTo(_ state: Bool) {
        collectionView.view.bounces = state
    }
    
    public func setIsScrollEnabled(_ state: Bool) {
        collectionView.view.isScrollEnabled = state
    }
}

