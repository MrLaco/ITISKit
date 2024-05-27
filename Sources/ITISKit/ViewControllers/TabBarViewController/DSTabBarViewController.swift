import UIKit

open class DSTabBarViewController: UITabBarController, UIViewControllerTransitioningDelegate, DSDesignableViewController {

    
    public var viewController: UIViewController {
        return self
    }
    
    public var customPresentModalAnimation: UIViewControllerAnimatedTransitioning?
    public var customNavigationControllerAnimation: UIViewControllerAnimatedTransitioning?
    public var customDismissModalAnimation: UIViewControllerAnimatedTransitioning?
    
    var progressHud: ProgressHUD!

    override open func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarAppearance()
        setUpProgressHud()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return DSAppearance.shared.main.statusBarStyle(for: traitCollection.userInterfaceStyle )
    }
    
    open override var prefersStatusBarHidden: Bool {
      return false
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return nil
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.transitioningDelegate = self
    }
    
    deinit {}
}

extension UITabBarController {
    
    public func setUpTabBarAppearance() {
                
        overrideUserInterfaceStyle = DSAppearance.shared.userInterfaceStyle
        tabBar.unselectedItemTintColor = DSAppearance.shared.main.tabBar.unselectedItemTint
        tabBar.tintColor = DSAppearance.shared.main.tabBar.itemTint
        tabBar.barTintColor = DSAppearance.shared.main.tabBar.barTint
        tabBar.isTranslucent = DSAppearance.shared.main.tabBar.translucent
        
        
        if let tabBarItems = tabBar.items {
            for item in tabBarItems {
                item.badgeColor = DSAppearance.shared.main.tabBar.badge
            }
        }
    }
}

extension DSTabBarViewController {

    public func loading(_ loading: Bool, delayShowLoading: Bool = true, file: String = #file, line: Int = #line) {
        
        guard let progressHud = self.progressHud else {
            return
        }
        
        var fileName = "No file name"
        if let file = file.components(separatedBy: "/").last {
            fileName = file
        }
        
        progressHud.loading(loading, delayShowLoading: delayShowLoading, file: fileName, line: line)
    }

    func setUpProgressHud() {
        if let navigationController = self.navigationController {
            for view in navigationController.view.subviews where view.tag == progressHUDTag {
                
                guard let view = view as? ProgressHUD else {
                    return
                }
                progressHud = view
            }

            if progressHud == nil {
                progressHud = ProgressHUD(onView: navigationController.view)
            }
        } else {
            progressHud = ProgressHUD(onView: self.view)
        }
    }
}

extension UITabBarController {
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return DSAppearance.shared.main.statusBarStyle(for: traitCollection.userInterfaceStyle )
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return nil
    }
}
