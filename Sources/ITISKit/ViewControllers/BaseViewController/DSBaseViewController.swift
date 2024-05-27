import UIKit
import Combine

open class DSBaseViewController: UIViewController, DSDesignableViewController, UIViewControllerTransitioningDelegate, Subscriber {
    
    public typealias Input = DSDesignable
    public typealias Failure = Never
    private var subscription: Subscription?
    
    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
        self.subscription = subscription
    }
    
    public func receive(_ input: Input) -> Subscribers.Demand {
        self.appearanceDidUpdate()
        return .none
    }
    
    public func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion: \(completion)")
    }
    
    public var appearance: DSDesignable = DSAppearance.shared.main
    public var lastTraitCollection: UITraitCollection?
    public var customDismissModalAnimation: UIViewControllerAnimatedTransitioning?
    public var customPresentModalAnimation: UIViewControllerAnimatedTransitioning?
    public var customNavigationControllerAnimation: UIViewControllerAnimatedTransitioning?
    
    public var hideNavigationBar: Bool = false
    public var viewController: UIViewController {
        return self
    }

    var progressHud: ProgressHUD!
    var messageHud: DSMessageHUD!    

    override open func viewDidLoad() {
        super.viewDidLoad()
        DSAppearance.shared.appearancePublisher.subscribe(self)
        setUpLargeTitleDisplayMode()
        setUpProgressHud()
        setUpMessageHud()
        updateAppearance()
        showNavigationBarShadow()
    }
    
    open func appearanceDidUpdate() {
        updateAppearance()
    }
    
    func updateAppearance() {
        self.appearance = DSAppearance.shared.main
        overrideUserInterfaceStyle = DSAppearance.shared.userInterfaceStyle
        navigationController?.setUpNavigationBarAppearance()
        tabBarController?.setUpTabBarAppearance()
        setNeedsStatusBarAppearanceUpdate()
    }
        
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentModalAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismissModalAnimation
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAppearance()
        
        if hideNavigationBar {
            hideNavigationBar()
        } else {
            showNavigationBar()
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent || self.isBeingDismissed  {
            subscription?.cancel()
        }
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return DSAppearance.shared.main.statusBarStyle(for: traitCollection.userInterfaceStyle )
    }
    
    open override var prefersStatusBarHidden: Bool {
      return false
    }

    public override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        lastTraitCollection = traitCollection
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lastTraitCollection = traitCollection
    }
    
    deinit {}
}

